class ServicesFactory
  class UnknownServiceTypeError < StandardError; end

  def self.create_service(type, service_params)
    case type
    when "StaticService"
      StaticService.new(service_params)
    when "DynamicService"
      DynamicService.new(service_params)
    else
      raise UnknownServiceTypeError, "Unknown service type: #{type}"
    end
  end

  def self.update_service(current_service, new_type, service_params)
    case new_type
    when "StaticService"
      service_params[:csv_headers] = filter_csv_headers(service_params[:csv_headers])
      new_instance = current_service.becomes!(StaticService)
      new_instance.type = "StaticService"
      new_instance.assign_attributes(service_params)
    when "DynamicService"
      new_instance = current_service.becomes!(DynamicService)
      new_instance.type = "DynamicService"
      new_instance.assign_attributes(service_params)
      new_instance.is_quote_needed = true
    else
      raise UnknownServiceTypeError, "Unknown service type: #{new_type}"
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
