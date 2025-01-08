# == Schema Information
#
# Table name: cart_items
#
#  id         :bigint           not null, primary key
#  price      :decimal(10, 2)
#  quantity   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cart_id    :bigint           not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_cart_items_on_cart_id     (cart_id)
#  index_cart_items_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id)
#  fk_rails_...  (product_id => products.id)
#
class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  before_save :set_price_at_submission # if: :order_pending?

  private

  def set_price_at_submission
    self.price ||= product.price
  end

  # def order_pending?
  #   order.status == "pending"
  # end
end
