# == Schema Information
#
# Table name: orders
#
#  id               :bigint           not null, primary key
#  email            :string
#  orderable_type   :string
#  shipping_address :jsonb
#  status           :string           default("pending")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  orderable_id     :bigint
#
# Indexes
#
#  index_orders_on_orderable  (orderable_type,orderable_id)
#
class Order < ApplicationRecord
  before_destroy :do_not_destroy
  belongs_to :orderable, polymorphic: true
  has_and_belongs_to_many :order_exports
  has_many :order_items
  has_many :products, through: :order_items

  ORDER_OPEN = "open"
  ORDER_PENDING = "pending"

  def scoped_order_items(store_id)
    order_items.find_all { |item| item.product.store_id === store_id }
  end

  def sorted_order_items
    order_items.includes(:product).order("products.name")
  end

  # def total_price
  #   order_items.includes(:product).sum { |item| item.product.price * item.quantity }
  # end
  #
  # def order_item_totals
  #   order_items.sum(:quantity)
  # end
  #
  # def is_ready_for_checkout
  #   object.status == Order::ORDER_OPEN && object.order_items.any?
  # end

  def open?
    status == ORDER_OPEN
  end

  def address1
    shipping_address["address1"]
  end

  def address2
    shipping_address["address2"]
  end

  def city
    shipping_address["city"]
  end

  def state
    shipping_address["state"]
  end

  def postal_code
    shipping_address["postal_code"]
  end

  private

  def do_not_destroy
    raise ActiveRecord::DeleteRestrictionError, "Orders cannot be destroyed"
  end
end
