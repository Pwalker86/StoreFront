# frozen_string_literal: true

require "csv"

class ShippingDetailsImportService
  def initialize(details_import_id)
    @details_import = ShippingDetailsImport.find(details_import_id)
    @shipping_details = []
  end

  def import
    begin
      parse_file
      save_shipping_details
    rescue StandardError => e
      Rails.logger.error("Error importing shipping details: #{e.message}")
    end
  end

  private

  def parse_file
    file = @details_import.import_file.download
    CSV.parse(file, headers: true) do |row|
      shipping_detail = ShippingDetail.new(row.to_hash)
      @shipping_details << shipping_detail
    end
  end

  def save_shipping_details
    @shipping_details.each(&:save)
  end
end
