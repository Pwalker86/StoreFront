class CartDecorator < Draper::Decorator
  delegate_all

  # Sorts the items here. Otherwise, the order changes every time an item is added.
  def sorted_cart_items
    object.cart_items.includes(:product).order("products.name")
  end

  def total_price
    object.cart_items.includes(:product).sum { |item| item.price * item.quantity }
  end

  def cart_item_totals
    object.cart_items.sum(:quantity)
  end
end
