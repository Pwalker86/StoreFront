require "test_helper"

class BaseOrderExporterTest < ActiveSupport::TestCase
  setup do
    @export = order_exports(:export_one)
    @fulfillment_partner = fulfillment_partners(:csv_partner)
    @orders = [orders(:order_one), orders(:order_two)]
  end

  test "initializing with correct attributes" do
    exporter = BaseOrderExporter.new(@export, @fulfillment_partner)

    # Use send to access protected attributes
    assert_equal @export, exporter.send(:export)
    assert_equal @fulfillment_partner, exporter.send(:fulfillment_partner)
    assert_equal @export.orders, exporter.send(:orders)
  end

  test "generate method raises NotImplementedError" do
    exporter = BaseOrderExporter.new(@export, @fulfillment_partner)

    assert_raises NotImplementedError do
      exporter.generate
    end
  end

  test "access to attributes" do
    exporter = BaseOrderExporter.new(@export, @fulfillment_partner)

    assert_respond_to exporter, :export, "should respond to export method"
    assert_respond_to exporter, :fulfillment_partner, "should respond to fulfillment_partner method"
    assert_respond_to exporter, :orders, "should respond to orders method"
  end

  # Test with concrete subclass
  test "subclass implements generate method" do
    # Create a test subclass that implements generate
    test_subclass = Class.new(BaseOrderExporter) do
      def generate
        "Test export"
      end
    end

    exporter = test_subclass.new(@export, @fulfillment_partner)
    assert_equal "Test export", exporter.generate
  end

  # Test inheritance chain
  test "child classes should inherit from BaseOrderExporter" do
    assert_includes CsvOrderExporter.ancestors, BaseOrderExporter
    assert_includes JsonOrderExporter.ancestors, BaseOrderExporter
  end
end
