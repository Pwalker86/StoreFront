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

  validates :store, presence: true

  def generate_export(orders)
    raise NotImplementedError, "Subclasses must implement this method"
  end

  # TODO: something like this in a separate file validation service
  def validate_file(file)
    raise NotImplementedError, "Subclasses must implement this method"
  end
end
