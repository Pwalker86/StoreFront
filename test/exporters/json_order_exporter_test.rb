require "test_helper"
require 'ostruct'

class JsonOrderExporterTest < ActiveSupport::TestCase
  setup do
    @export = order_exports(:export_two)
    @json_partner = fulfillment_partners(:json_partner)

    # Set up order with all required fields
    @order = orders(:order_one)

    @exporter = JsonOrderExporter.new(@export, @json_partner)
  end

  test "should generate valid JSON" do
    json_output = @exporter.generate

    # Verify it's valid JSON
    assert_nothing_raised do
      JSON.parse(json_output)
    end
  end

  test "should include basic order data" do
    json_output = @exporter.generate
    parsed_json = JSON.parse(json_output)

    assert_equal 1, parsed_json.size
    order_data = parsed_json.first

    assert_equal @order.id, order_data["id"]
    assert_equal @order.email, order_data["email"]
    assert_equal @order.status, order_data["status"]
    assert_not_nil order_data["created_at"]
  end

  test "should include order items when present" do
    # Create test order items
    product = products(:product_one)

    json_output = @exporter.generate
    parsed_json = JSON.parse(json_output)
    order_data = parsed_json.first

    assert order_data.key?("items"), "JSON should include items key"
    assert_equal 2, order_data["items"].size

    item_data = order_data["items"].first
    assert_equal product.id, item_data["product_id"]
    assert_equal product.name, item_data["product_name"]
    assert_equal 1, item_data["quantity"]
    assert_equal "9.99", item_data["price"]
  end

  test "should apply schema transformations when file_schema is present" do
    # Set up a simple schema for testing
    @json_partner.define_singleton_method(:file_schema) do
      { "present" => true }
    end

    # Stub the transformations for testing
    @exporter.define_singleton_method(:apply_schema_transformations) do |data|
      data.merge(transformed: true)
    end

    json_output = @exporter.generate
    parsed_json = JSON.parse(json_output)
    order_data = parsed_json.first

    assert order_data["transformed"], "JSON should be transformed according to schema"
  end

  test "should handle multiple orders" do
    # Add a second order
    @export.orders = [@order, orders(:order_two)]

    json_output = @exporter.generate
    parsed_json = JSON.parse(json_output)

    # Verify multiple orders in output
    assert_equal 2, parsed_json.size
  end

  test "should generate pretty-printed JSON" do
    json_output = @exporter.generate

    # Check for newlines and indentation which indicate pretty printing
    assert_includes json_output, "\n"
    assert_includes json_output, "  " # Indentation
  end
end
