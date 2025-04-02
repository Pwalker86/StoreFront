# frozen_string_literal: true

require "csv"

class ShippingDetailsImportService
  include ActiveModel::Model

  attr_accessor :file, :shipping_details

  validates :file, presence: true
  validate :validate_file_format

  def initialize(attributes = {})
    super
    @file = attributes[:file]
    @shipping_details = []
  end

  def import
    debugger
    return false unless valid?

    parse_file
    save_shipping_details
  end

  private

  def parse_file
    CSV.foreach(file.path, headers: true) do |row|
      shipping_detail = ShippingDetail.new(row.to_hash)
      shipping_details << shipping_detail
    end
  end

  def save_shipping_details
    shipping_details.each(&:save)
  end

  def validate_file_format
    errors.add(:file, "must be a CSV file") unless file.content_type == "text/csv"
  end
end
