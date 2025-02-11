# Handles the user submitting ("checking out") an order.
# sets status to 'pending' and saves the order_items' prices as they were at time of sale.
# payment processing would be invoked here in the future.
#
class ConvertCartToOrderService
  def initialize(cart, order_params, user)
    @cart = cart
    @order_params = order_params
    @order = user.orders.new(email: @order_params[:email])
  end

  def process
    convert_cart_items
    set_guest_email
    update_status
    # set_sales_prices
    set_order_address
    if @order.save!
      @cart.cart_items.destroy_all
    end
  end

  private

  def convert_cart_items
    @cart.cart_items.each do |item|
      @order.order_items.new(price: item.price, quantity: item.quantity, product_id: item.product_id)
    end
  end

  # Updates the status of the order to 'pending'. After this, the order will be sent to fulfillment.
  def update_status
    @order.status = "pending"
  end

  # TODO: This still needs to be re-implemented
  # # Sets the price of each order item to the price of the product at the time of sale.
  # def set_sales_prices
  #   @order.order_items.each do |item|
  #     item.price = item.product.price
  #   end
  # end

  # Sets the shipping address for the order.
  def set_order_address
    # TODO: Need to refactor order model to use normal string columns for each address value.
    # That's how it's been accessed anyway and would reduce reliance on a jsonb datatype being available in the DB.
    @order.shipping_address = {
      address1: @order_params[:address1],
      address2: @order_params[:address2],
      city: @order_params[:city],
      state: @order_params[:state],
      postal_code: @order_params[:postal_code]
    }
  end

  # If the order has a guest user, it updates the guest's email
  # with the provided email from the address parameters and saves the guest user.
  def set_guest_email
    if @order.orderable.is_a? Guest
      @order.orderable.email = @order_params[:email]
      @order.orderable.save!
    end
  end
end
