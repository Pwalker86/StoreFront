class CartsController < ApplicationController
  def checkout
    @order = @active_user.orders.new
    @email = @active_user.is_a?(User) ? @active_user.email : ""
  end

  def update
    service = CartUpdateService.new(params[:user_entity], params[:user_id], params[:product_id], params[:quantity])
    result = service.call

    case result[:status]
    when :removed
      redirect_to user_cart_path, notice: result[:message]
    when :updated
      redirect_to user_cart_path, notice: result[:message]
    when :error
      redirect_to user_cart_path, alert: result[:message]
    end
  end

  def destroy
  end
end
