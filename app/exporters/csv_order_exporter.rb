# frozen_string_literal: true

require "csv"

class CsvOrderExporter < BaseOrderExporter
  DEFAULT_HEADERS = [ "order_id", "email", "full_name", "address1", "address2", "city", "state", "postal_code", "instructions" ].freeze

  def generate
    headers = determine_headers

    CSV.generate(headers: true) do |csv|
      csv << headers

      orders.each do |order|
        csv << headers.map { |header| extract_order_field(order, header) }
      end
    end
  end

  private

  def determine_headers
    # Use the partner's csv_headers if available, otherwise use defaults
    if fulfillment_partner.csv_headers.present?
      fulfillment_partner.csv_headers
    else
      DEFAULT_HEADERS
    end
  end

  # As of now, this is only needed for an alias between order_id and id, but it can be expanded if you want the header name to be different than the model attribute
  def extract_order_field(order, field)
    case field
    when "order_id", "id"
      order.id
    when "email"
      order.email
    when "full_name"
      order.respond_to?(:full_name) ? order.full_name : nil
    when "address1"
      order.respond_to?(:address1) ? order.address1 : nil
    when "address2"
      order.respond_to?(:address2) ? order.address2 : nil
    when "city"
      order.respond_to?(:city) ? order.city : nil
    when "state"
      order.respond_to?(:state) ? order.state : nil
    when "postal_code"
      order.respond_to?(:postal_code) ? order.postal_code : nil
    when "instructions"
      order.respond_to?(:instructions) ? order.instructions : nil
    else
      nil
    end
  end
end
