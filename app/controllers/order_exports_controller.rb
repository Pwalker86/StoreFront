class OrderExportsController < ApplicationController
  def index
  end

  def show
  end

  def create
    orders = Order.where(id: order_export_params[:order_ids])
    @order_export = OrderExport.new
    @order_export.date_exported_at = Time.current
    @order_export.orders = orders
    @order_export.save
    redirect_to store_admin_store_orders_path(current_store_admin, current_store_admin.store), notice: "Order export created!"
  end

  private

  def order_export_params
    params.expect(order_export: { order_ids: [] })
  end
end
