class OrderExportsController < ApplicationController
  def index
  end

  def show
  end

  def create
    orders = Order.where(id: order_export_params[:order_ids])
    @order_export = OrderExport.new(date_exported_at: Time.current, orders: orders)
    if @order_export.save!
      csv_data = OrderExportFileFactory.create_exporter(@order_export.id, order_export_params[:store_id]).generate
      send_data csv_data, filename: "orders_export_#{Time.current.strftime('%Y-%m-%d_%H:%M:%S')}.csv"
    else
      redirect_to store_admin_store_orders_path(current_store_admin, current_store_admin.store), alert: "Failed to export orders"
    end
  end

  private

  def order_export_params
    params.expect(order_export: [ :store_id, order_ids: [] ])
  end
end
