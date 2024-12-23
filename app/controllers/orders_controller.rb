class OrdersController < ApplicationController
  # @return [ActiveRecord::Relation<Order>]
  def index
    if @active_user
      @orders = get_user_orders
    end
  end

  # @return decorated [Order]
  def show
    @order = OrderDecorator.decorate(Order.find(params[:id]))
  end

  def create
    user = order_params[:user_entity].constantize.find(order_params[:user_entity_id])
    cart = user.cart
    begin
      ConvertCartToOrderService.new(cart, order_params, user).process
      if @active_user.is_a? Guest
        redirect_to root_path
      elsif @active_user.is_a? User
        redirect_to orders_path
      end
    rescue StandardError => e
      Rails.logger.error e.message
      redirect_to root_path, alert("something went wrong")
    end
  end

  def submit
    @order = Order.find(order_submit_params[:order_id])
    if OrderSubmitService.new(@order, order_params).submit
      # Clear guest session. If the user needs to view their order,
      # they'll see it on the confirmation page or from the order id we provide them in an email
      session[:guest_id] = nil
      redirect_to order_confirmation_path(@order), notice: "Order submitted successfully"
    else
      render @open_order, alert: "Order failed to submit"
    end
  end

  def confirmation
    @order = OrderDecorator.decorate(Order.find(order_params[:order_id]))
  end

  def update
  end

  private

  def get_user_orders
    OrderDecorator.decorate_collection(@active_user.orders)
  end

  def ensure_active_user
    redirect_to root_path, alert: "Cannot find user" unless @active_user
  end

  def order_params
    params.require(:order).permit(:user_entity, :user_entity_id, :address1, :address2, :city, :state, :postal_code, :email)
  end

  def order_submit_params
    params.require(:order).permit(:order_id)
  end
end
