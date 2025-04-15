# Handles the user submitting ("checking out") an order.
# sets status to 'pending' and saves the order_items' prices as they were at time of sale.
# payment processing would be invoked here in the future.
#
class ConvertCartToOrderService
  class ConvertCartToOrderError < StandardError; end

  def initialize(cart, order_params, user)
    @cart = cart
    @order_params = order_params
    @order = user.orders.new(email: @order_params[:email])
  end

  def call
    begin
      convert_cart_items
      update_status
      set_order_address
      set_guest_email
      if @order.save!
        @cart.cart_items.destroy_all
      end
      @order
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Error processing order: #{e.message}"
      raise ConvertCartToOrderError, "Failed to convert cart to order: #{e.message}"
    end
  end

  private

  def convert_cart_items
    @cart.cart_items.each do |item|
      @order.order_items.new(price: item.price * item.quantity, quantity: item.quantity, product_id: item.product_id)
    end
  end

  # Updates the status of the order to 'pending'. After this, the order will be sent to fulfillment.
  def update_status
    @order.status = "pending"
  end

  # Sets the shipping address for the order.
  def set_order_address
    @order.assign_attributes(
      full_name: @order_params[:full_name],
      address1: @order_params[:address1],
      address2: @order_params[:address2],
      city: @order_params[:city],
      state: @order_params[:state],
      postal_code: @order_params[:postal_code]
    )
  end

  # If the order has a guest user, it updates the guest's email
  # with the provided email from the checkout parameters and saves the guest user.
  def set_guest_email
    # TODO: check how to do this better.
    if @order.orderable.is_a? Guest
      @order.orderable.email = @order_params[:email]
      @order.orderable.save!
    end
  end
end
