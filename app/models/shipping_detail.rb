# == Schema Information
#
# Table name: shipping_details
#
#  id              :bigint           not null, primary key
#  tracking_number :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  order_id        :bigint           not null
#
# Indexes
#
#  index_shipping_details_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
class ShippingDetail < ApplicationRecord
  belongs_to :order
end
