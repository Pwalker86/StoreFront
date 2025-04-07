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
class CsvPartner < FulfillmentPartner
  CSV_HEADER_OPTIONS = [ "email", "full_name", "address1", "address2", "city", "state", "postal_code", "instructions" ].freeze

  def generate_export(orders)
    puts "Generating CSV export for #{orders.count} orders"
  end
end
