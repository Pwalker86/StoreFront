require "json-schema"
# == Schema Information
#
# Table name: fulfillment_partners
#
#  id          :bigint           not null, primary key
#  csv_headers :string           default([]), is an Array
#  email       :string
#  file_format :string           not null
#  file_schema :jsonb
#  location    :string
#  name        :string           not null
#  phone       :string
#  type        :string           not null
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
class FulfillmentPartner < ApplicationRecord
  self.abstract_class = true
  self.table_name = "fulfillment_partners"

  belongs_to :store
  has_one_attached :file_schema_json

  validates :store, presence: true

  after_create_commit :write_schema_to_model
  before_update do
    if attachment_changes["file_schema_json"].present?
      write_schema_to_model
    end
  end

  def generate_export(orders)
    raise NotImplementedError, "Subclasses must implement this method"
  end

  # TODO: something like this in a separate file validation service
  def validate_file(file)
    raise NotImplementedError, "Subclasses must implement this method"
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
