require "fileutils"

class FulfillmentPartner::WriteSchemaJob
  include Sidekiq::Job

  def perform(partner_id)
    debugger
    @partner = FulfillmentPartner.find(partner_id)
    schema_content = @partner.file_schema.download
    parsed_schema = JSON.parse(schema_content)
    unless File.directory?("../../../lib/partners/schemas")
      FileUtils.mkdir_p("../../../lib/partners/schemas")

      file_path = Rails.root.join("lib", "partners", "schemas", "partner_#{partner_id}.json")
      File.write(file_path, JSON.pretty_generate(parsed_schema))
    end
  end
end
