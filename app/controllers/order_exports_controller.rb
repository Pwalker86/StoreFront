class OrderExportsController < ApplicationController
  def index
  end

  def show
  end

  def create
    debugger
    @order_export = OrderExport.new
    @order_export.date_exported_at = Time.current
    @order_export.save
    redirect_to order_exports_path, notice: "Order export created!"
  end
end
