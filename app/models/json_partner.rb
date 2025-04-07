# == Schema Information
#
# Table name: fulfillment_partners
#
#  id          :bigint           not null, primary key
#  csv_headers :string           default([]), is an Array
#  email       :string
#  file_schema :jsonb
#  location    :string
#  name        :string           not null
#  phone       :string
#  type        :string           default("CsvPartner"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  store_id    :bigint
#
# Indexes
#
#  index_fulfillment_partners_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
class JsonPartner < FulfillmentPartner
  def generate_export(orders)
    puts "Generating JSON export for #{orders.count} orders"
    orders.to_json
  end

  def validate_file(file)
    JSON::Validator.validate!(file_schema, file)
  end

  private

  def write_schema_to_model
    if file_schema_json.attached?
      FulfillmentPartner::WriteSchemaJob.perform_async(id)
    else
      Rails.logger.error("No file schema JSON attached for partner #{id}")
    end
  end
end
