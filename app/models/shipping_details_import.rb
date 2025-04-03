# == Schema Information
#
# Table name: shipping_details_imports
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  store_admin_id :bigint           not null
#
# Indexes
#
#  index_shipping_details_imports_on_store_admin_id  (store_admin_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_admin_id => store_admins.id)
#
class ShippingDetailsImport < ApplicationRecord
  belongs_to :store_admin
  has_one_attached :import_file
end
