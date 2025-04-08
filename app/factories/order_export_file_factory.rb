# frozen_string_literal: true

class OrderExportFileFactory
  class UnknownExporterTypeError < StandardError; end

  def self.create_exporter(export_id, store_id)
    store = Store.find store_id
    export = OrderExport.find export_id
    fulfillment_partner = store.fulfillment_partner

    case fulfillment_partner.type
    when "CsvPartner"
      CsvOrderExporter.new(export, fulfillment_partner)
    when "JsonPartner"
      JsonOrderExporter.new(export, fulfillment_partner)
    else
      raise UnknownExporterTypeError, "Unknown fulfillment partner type: #{fulfillment_partner.type}"
    end
  end
end
