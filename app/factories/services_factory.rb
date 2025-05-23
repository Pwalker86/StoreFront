class ServicesFactory
  class UnknownServiceTypeError < StandardError; end

  def self.create_service(type, service_params)
    case type
    when "StaticService"
      service = StaticService.new(service_params)
    when "DynamicService"
      service = DynamicService.new(service_params)
    else
      raise UnknownServiceTypeError, "Unknown service type: #{type}"
    end
    service
  end

  def self.update_service(current_service, new_type, service_params)
    case new_type
    when "StaticService"
      new_instance = current_service.becomes!(StaticService)
      new_instance.type = "StaticService"
      new_instance.assign_attributes(service_params)
      new_instance.is_quote_needed = false
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
# service_params = { name: "Example Service", description: "An example service", duration_in_hours: 2, rate_per_hour: 50, type: "StaticService", is_quote_needed: false }
# service = ServicesFactory.create_service(service_params[:type], service_params)
# puts service.inspect
# service = Service.find...
# service = service.update_service(service, service_params[:type], service_params)
# puts service.inspect
#
