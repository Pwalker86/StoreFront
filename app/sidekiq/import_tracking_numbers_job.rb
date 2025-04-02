class ImportTrackingNumbersJob
  include Sidekiq::Job

  def perform(file)
    debugger
    ShippingDetailsImportService.new(file: file).import
    redirect_to store_admin_store_orders_path(current_store_admin, current_store_admin.store), notice: "Shipping details imported successfully."
  end
end
