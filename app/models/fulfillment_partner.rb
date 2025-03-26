# == Schema Information
#
# Table name: fulfillment_partners
#
#  id             :bigint           not null, primary key
#  email          :string
#  file_format    :string           not null
#  file_structure :jsonb            not null
#  location       :string
#  name           :string           not null
#  phone          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  store_id       :bigint
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
  belongs_to :store
  has_rich_text :file_structure

  validates :store, presence: true

  def validate_file(file)
    case file_format
    when "csv"
      validate_csv(file)
    when "json"
      validate_json(file)
    else
      errors.add(:file_format, "is not supported")
    end
  end

  def validate_csv(file)
    # Implement CSV validation logic here
  end

  def validate_json(file)
    # Implement JSON validation logic here
  end

  def validate_xml(file)
    # Implement XML validation logic here
  end
end
