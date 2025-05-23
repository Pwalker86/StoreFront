class CartsController < ApplicationController
  def show
    authorize active_user.cart
  end

  def checkout
    @order = active_user.orders.new
    @email = active_user.is_a?(User) ? active_user.email : ""
  end

  def update
    authorize active_user.cart
    begin
      result = AddProductOrServiceFactory.add(active_user.cart, { item_entity: params[:item_entity], user_entity: params[:user_entity], user_id: params[:user_id], product_id: params[:product_id], quantity: params[:quantity] })
    rescue AddProductOrServiceFactory::UnknownProductOrServiceError => e
      Rails.logger.error("Unexpected error: #{e.message}, params: #{params.inspect}")
      redirect_back(fallback_location: root_path) and return
    end

    case result[:status]
    when :error
      redirect_to user_cart_path, alert: result[:message]
    when :updated
      redirect_to user_cart_path, notice: result[:message]
    end
  end

  def destroy
  end
end
