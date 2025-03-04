class OrdersController < ApplicationController
  # @return decorated collection of [Orders]
  def index
    @orders = @active_user.orders
    authorize @orders.first
  end

  # @return decorated [Order]
  def show
    @order = Order.find(params[:id])
    authorize @order
  end

  def create
    user = EntityLookup.find_entity(order_params[:user_entity], order_params[:user_entity_id])
    cart = user.cart
    authorize cart
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

  def confirm
    redirect_to order_path(params[:order_id])
  end

  private

  def order_params
    params.require(:order).permit(:user_entity, :user_entity_id, :address1, :address2, :city, :state, :postal_code, :email)
  end
end
