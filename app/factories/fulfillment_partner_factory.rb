class FulfillmentPartnerFactory
  class UnknownFulfillmentPartnerTypeError < StandardError; end

  def self.create_fulfillment_partner(type, partner_params)
    case type
    when "CsvPartner"
      partner_params[:csv_headers] = filter_csv_headers(partner_params[:csv_headers])
      CsvPartner.new(partner_params)
    when "JsonPartner"
      JsonPartner.new(partner_params)
    else
      raise UnknownFulfillmentPartnerTypeError, "Unknown fulfillment partner type: #{type}"
    end
  end

  def self.update_fulfillment_partner(current_partner, new_type, partner_params)
    case new_type
    when "CsvPartner"
      partner_params[:csv_headers] = filter_csv_headers(partner_params[:csv_headers])
      new_instance = current_partner.becomes!(CsvPartner)
      new_instance.type = "CsvPartner"
      new_instance.assign_attributes(partner_params)
      new_instance.file_schema = nil
    when "JsonPartner"
      new_instance = current_partner.becomes!(JsonPartner)
      new_instance.type = "JsonPartner"
      new_instance.assign_attributes(partner_params)
      new_instance.csv_headers = []
    else
      raise UnknownFulfillmentPartnerTypeError, "Unknown fulfillment partner type: #{type}"
    end
    new_instance
  end

  def self.filter_csv_headers(csv_headers)
    csv_headers.select { |k, v| v == "true" }.keys
  end
end

# Example usage:
# partner = FulfillmentPartnerFactory.create_fulfillment_partner('CsvPartner', {attributes_hash})
# puts partner.class # => CsvPartner
#
# partner = FulfillmentPartnerFactory.update_fulfillment_partner(existing_partner, 'JsonPartner', {attributes_hash})
# puts partner.class # => JsonPartner
