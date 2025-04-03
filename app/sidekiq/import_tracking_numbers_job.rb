class ImportTrackingNumbersJob
  include Sidekiq::Job

  def perform(import_id)
    ShippingDetailsImportService.new(import_id).import
  end
end
