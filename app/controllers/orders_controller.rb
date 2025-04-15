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
      order = ConvertCartToOrderService.new(cart, order_params, user).call
      redirect_to order
    rescue ConvertCartToOrderService::ConvertCartToOrderError, EntityLookup::EntityLookupError => e
      redirect_to root_path, alert: "something went wrong: #{e.message}"
    end
  end

  def confirm
    redirect_to order_path(params[:order_id])
  end

  private

  def pundit_user
    @active_user
  end

  def order_params
    params.require(:order).permit(:user_entity, :user_entity_id, :full_name, :address1, :address2, :city, :state, :postal_code, :email)
  end
end
