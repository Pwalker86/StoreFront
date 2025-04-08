require "test_helper"
require 'ostruct'

class CsvOrderExporterTest < ActiveSupport::TestCase
  setup do
    @export = order_exports(:export_one)
    @csv_partner = fulfillment_partners(:csv_partner)

    # Set up order with all required fields
    @order = orders(:order_one)

    # Set up CSV headers on fulfillment partner
    @csv_partner.csv_headers = ["order_id", "email", "full_name", "address1"]

    @exporter = CsvOrderExporter.new(@export, @csv_partner)
  end

  test "should generate CSV with partner's headers when available" do
    # Configure partner with custom headers
    @csv_partner.csv_headers = ["order_id", "email"]

    csv_output = @exporter.generate

    # Parse the generated CSV
    parsed_csv = CSV.parse(csv_output, headers: true)

    # Check that the CSV has expected headers
    assert_equal ["order_id", "email"], parsed_csv.headers

    # Check that the CSV has the expected data
    assert_equal @order.id.to_s, parsed_csv[0]["order_id"]
    assert_equal @order.email, parsed_csv[0]["email"]
  end

  test "should generate CSV with default headers when partner has no headers" do
    # Clear partner headers
    @csv_partner.csv_headers = []

    csv_output = @exporter.generate

    # Parse the generated CSV
    parsed_csv = CSV.parse(csv_output, headers: true)

    # Check that the CSV has default headers
    assert_equal CsvOrderExporter::DEFAULT_HEADERS, parsed_csv.headers
  end

  test "should extract order_id field correctly" do
    value = @exporter.send(:extract_order_field, @order, "order_id")
    assert_equal @order.id, value
  end

  test "should extract id as alias for order_id field" do
    value = @exporter.send(:extract_order_field, @order, "id")
    assert_equal @order.id, value
  end

  test "should extract email field correctly" do
    value = @exporter.send(:extract_order_field, @order, "email")
    assert_equal @order.email, value
  end

  test "should extract address fields correctly" do
    # Check address1
    value = @exporter.send(:extract_order_field, @order, "address1")
    assert_equal @order.address1, value

    # Check address2
    value = @exporter.send(:extract_order_field, @order, "address2")
    assert_equal @order.address2, value
  end

  test "should extract location fields correctly" do
    # Check city
    value = @exporter.send(:extract_order_field, @order, "city")
    assert_equal @order.city, value

    # Check state
    value = @exporter.send(:extract_order_field, @order, "state")
    assert_equal @order.state, value

    # Check postal_code
    value = @exporter.send(:extract_order_field, @order, "postal_code")
    assert_equal @order.postal_code, value
  end

  test "should extract instructions correctly" do
    value = @exporter.send(:extract_order_field, @order, "instructions")
    assert_equal @order.instructions, value
  end

  test "should return nil for unknown fields" do
    value = @exporter.send(:extract_order_field, @order, "unknown_field")
    assert_nil value
  end

  test "should handle missing attributes gracefully" do
    # Create a minimal order object that doesn't respond to all methods
    minimal_order = OpenStruct.new(
      id: 123,
      email: "test@example.com"
    )

    # These should return nil rather than raising errors
    assert_nil @exporter.send(:extract_order_field, minimal_order, "full_name")
    assert_nil @exporter.send(:extract_order_field, minimal_order, "address1")
  end

  test "should generate valid CSV for multiple orders" do
    csv_output = @exporter.generate
    parsed_csv = CSV.parse(csv_output, headers: true)

    # Check that the CSV has the expected number of rows
    assert_equal 2, parsed_csv.size
  end
end
