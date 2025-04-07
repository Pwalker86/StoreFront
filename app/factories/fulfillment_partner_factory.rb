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
end

# Example usage:
# partner = FulfillmentPartnerFactory.create_fulfillment_partner('Amazon')
# puts partner.class # => AmazonFulfillmentPartner
#
