class OrdersController < ApplicationController
  # @return decorated collection of [Orders]
  def index
    if !@active_user
      redirect_to root_path, alert: "You cannot access this page" and return
    end
    @orders = @active_user.orders
    if @orders.any?
      authorize @orders.first
    end
  end

  # @return decorated [Order]
  def show
    @order = Order.find(params[:id])
    authorize @order
  end

  def create
    begin
      user = EntityLookup.find_entity(order_params[:user_entity], order_params[:user_entity_id])
      cart = user.cart
      authorize cart
      ConvertCartToOrderService.new(cart, order_params, user).process
      if @active_user.is_a? Guest
        redirect_to root_path
      elsif @active_user.is_a? User
        redirect_to orders_path
      end
    rescue StandardError
      redirect_to root_path, alert: "something went wrong"
    end
  end

  def confirm
    redirect_to order_path(params[:order_id])
  end

  private

  def order_params
    params.require(:order).permit(:user_entity, :user_entity_id, :address1, :address2, :city, :state, :postal_code, :email)
  end
end
