# == Schema Information
#
# Table name: order_items
#
#  id         :bigint           not null, primary key
#  price      :decimal(10, 2)
#  quantity   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_order_items_on_order_id    (order_id)
#  index_order_items_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_id => products.id)
#
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  # Ensure price_at_submission is set when the order is submitted
  before_save :set_price_at_submission, if: :order_pending?

  def store
    Store.where(products: [ self.product.store ]).first
  end

  private

  def set_price_at_submission
    self.price ||= product.price
  end

  def order_pending?
    order.status == "pending"
  end
end
