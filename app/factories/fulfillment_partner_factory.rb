class FulfillmentPartnerFactory
  def self.create_fulfillment_partner(type, partner_params)
    case type
    when "CsvPartner"
      partner_params[:csv_headers] = partner_params[:csv_headers].select { |k, v| v === "true" }.keys
      CsvPartner.new(partner_params)
    when "JsonPartner"
      JsonPartner.new(partner_params)
    else
      raise "Unknown fulfillment partner type: #{partner_type}"
    end
  end

  def self.update_fulfillment_partner(current_partner, new_type, partner_params)
    case new_type
    when "CsvPartner"
      partner_params[:csv_headers] = partner_params[:csv_headers].select { |k, v| v === "true" }.keys
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
      raise "Unknown fulfillment partner type: #{partner_type}"
    end
    new_instance
  end
end

# Example usage:
# partner = FulfillmentPartnerFactory.create_fulfillment_partner('CsvPartner', {attributes_hash})
# puts partner.class # => CsvPartner
#
# partner = FulfillmentPartnerFactory.update_fulfillment_partner(existing_partner, 'JsonPartner', {attributes_hash})
# puts partner.class # => JsonPartner
