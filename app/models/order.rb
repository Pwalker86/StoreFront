class Order < ApplicationRecord
  belongs_to :orderable, polymorphic: true
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  def scoped_order_items(store_id)
    self.order_items.find_all { |item| item.product.store_id === store_id }
  end

  def destroy
    raise ActiveRecord::ReadOnlyRecord, "Orders cannot be destroyed"
  end

  def destroy!
    raise ActiveRecord::ReadOnlyRecord, "Orders cannot be destroyed"
  end

  ORDER_OPEN = "open"
  ORDER_PENDING = "pending"

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
end
