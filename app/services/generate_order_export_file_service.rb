## frozen_string_literal: true

class GenerateOrderExportFileService
  def initialize(export_id)
    @export = OrderExport.find(export_id)
  end

  def call
    # TODO: need to update after updating system to include more customer details
    # TODO: need to implement using the fulfilllment partner schema (json) or required fields (csv)
    require "csv"
    orders = @export.orders
    CSV.generate(headers: true) do |csv|
      csv << [ "Order ID", "Customer Name", "Total Price" ] # Add your desired headers
      orders.each do |order|
        csv << [ order.id, order.email ] # Add your desired fields
      end
    end
  end
end
