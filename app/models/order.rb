# == Schema Information
#
# Table name: orders
#
#  id             :bigint           not null, primary key
#  address1       :string
#  address2       :string
#  city           :string
#  email          :string
#  full_name      :string
#  instructions   :text
#  orderable_type :string
#  postal_code    :string
#  state          :string
#  status         :string           default("pending")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  orderable_id   :bigint
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
  has_many :shipping_details

  validates :full_name, :address1, :city, :postal_code, :state, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :status, inclusion: { in: %w[pending open shipped delivered] }
  validates :orderable, presence: true

  ORDER_OPEN = "open"
  ORDER_PENDING = "pending"

  def last_export
    order_exports.last
  end

  def scoped_order_items(store_id)
    order_items.includes(:product).find_all { |item| item.product.store_id === store_id }
  end

  def sorted_order_items
    order_items.includes(:product).order("products.name")
  end

  def total_price
    order_items.includes(:product).sum { |item| item.product.price * item.quantity }
  end

  def open?
    status == ORDER_OPEN
  end

  private

  def do_not_destroy
    raise ActiveRecord::DeleteRestrictionError, "Orders cannot be destroyed"
  end
end
