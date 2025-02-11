require "test_helper"

class OrderDecoratorTest < Draper::TestCase
  test "is_ready_for_checkout" do
    order = orders(:open_order)
    decorated = OrderDecorator.decorate(order)
    assert decorated.is_ready_for_checkout
  end

  test "order_item_totals" do
    order = orders(:order_one)
    decorated = OrderDecorator.decorate(order)
    assert_equal 4, decorated.order_item_totals
  end

  test "total_price" do
    order = orders(:order_one)
    decorated = OrderDecorator.decorate(order)
    assert_equal "24.96", decorated.total_price.to_digits
  end

  test "scoped_order_items" do
    order = orders(:order_one)
    store = stores(:store_one)
    decorated = OrderDecorator.decorate(order)
    assert_not_includes decorated.scoped_order_items(store.id), order_items(:order_item_three)
  end
end
