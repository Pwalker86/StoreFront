# == Schema Information
#
# Table name: cart_service_items
#
#  id         :bigint           not null, primary key
#  price      :decimal(10, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cart_id    :bigint           not null
#  service_id :bigint           not null
#
# Indexes
#
#  index_cart_service_items_on_cart_id     (cart_id)
#  index_cart_service_items_on_service_id  (service_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id)
#  fk_rails_...  (service_id => services.id)
#
class CartServiceItem < ApplicationRecord
  belongs_to :cart
  belongs_to :service
end
