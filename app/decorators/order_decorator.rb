class OrderDecorator < Draper::Decorator
  delegate_all
  decorates_associations :order_item

  # @return [ActiveRecord::Relation][OrderItems] scoped to the current store admin's store
  def scoped_order_items(store_id)
    object.order_items.find_all { |item| item.product.store_id === store_id }
  end

  # @return [ActiveRecord::Relation] the sorted order items
  def sorted_order_items
    object.order_items.includes(:product).order("products.name")
  end

  # Calculates the total price of the order by summing the price of each product multiplied by its quantity.
  # @return [Float] the total price of the order
  def total_price
    object.order_items.includes(:product).sum { |item| item.product.price * item.quantity }
  end

  # Returns the total quantity of items in the order.
  #
  # @return [Integer] the sum of the quantities of all order items
  def order_item_totals
    object.order_items.sum(:quantity)
  end

  # Checks if the order is ready for checkout.
  #
  # An order is considered ready for checkout if its status is `ORDER_OPEN`
  # and it has at least one order item.
  #
  # @return [Boolean] true if the order is ready for checkout, false otherwise
  def is_ready_for_checkout
    object.status == Order::ORDER_OPEN && object.order_items.any?
  end
end
