require "test_helper"

class ConvertCartToOrderServiceTest < ActiveSupport::TestCase
  def setup
    @user = users(:user_one)
    @user_cart = carts(:user_cart)
    @order_params = {
      email: "test@example.com",
      full_name: "John Doe",
      address1: "123 Main St",
      address2: "Apt 4B",
      city: "Test City",
      state: "TS",
      postal_code: "12345"
    }
    @service = ConvertCartToOrderService.new(@user_cart, @order_params, @user)
  end

  test "successfully converts cart to order" do
    assert_difference "Order.count", 1 do
      assert_difference "OrderItem.count", @user_cart.cart_items.count do
        order = @service.call
        assert_equal "pending", order.status
        assert_equal @order_params[:email], order.email
        assert_equal @order_params[:full_name], order.full_name
        assert_empty @user_cart.cart_items
      end
    end
  end

  test "raises error when order is invalid" do
    @order_params[:email] = nil # Invalid email
    service = ConvertCartToOrderService.new(@user_cart, @order_params, @user)
    assert_no_difference "Order.count" do
      assert_raises ConvertCartToOrderService::ConvertCartToOrderError do
        service.call
      end
    end
  end

  test "sets guest email when orderable is a guest" do
    guest = guests(:guest_one)
    guest_cart = carts(:guest_cart)
    @order_params[:email] = "guest@example.com"
    service = ConvertCartToOrderService.new(guest_cart, @order_params, guest)

    assert_difference "Order.count", 1 do
      order = service.call
      assert_equal "guest@example.com", order.orderable.email
    end
  end
end
