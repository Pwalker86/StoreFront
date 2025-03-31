class FulfillmentPartner::WriteSchemaJob
  include Sidekiq::Job

  def perform(partner_id)
    begin
      @partner = FulfillmentPartner.find(partner_id)
      schema_content = @partner.file_schema_json.download
      parsed_schema = JSON.parse(schema_content)
      @partner.update!(file_schema: parsed_schema)
    rescue JSON::ParserError, ActiveRecord::ActiveRecordError => e
      Rails.logger.error("Failed to save JSON schema to partner model, fulfillment partner #{partner_id}: #{e.message}")
    end
  end
end
