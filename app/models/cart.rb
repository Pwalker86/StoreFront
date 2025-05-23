# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  guest_id   :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_carts_on_guest_id  (guest_id)
#  index_carts_on_user_id   (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (guest_id => guests.id)
#  fk_rails_...  (user_id => users.id)
#
class Cart < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :guest, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  has_many :cart_service_items, dependent: :destroy
  has_many :services, through: :cart_service_items

  def cart_item_totals
    cart_items.sum(:quantity)
  end

  def sorted_cart_items
    cart_items.includes(:product).order("products.name")
  end

  def total_price
    cart_items.includes(:product).sum { |item| item.price * item.quantity }
  end
end
