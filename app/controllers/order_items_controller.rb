# TODO: check that this can be removed
class OrderItemsController < ApplicationController
  def create
    @product = Product.find_by(id: params[:product_id])
    @order_item = @open_order.order_items.find_or_create_by(product: @product)
    @order_item.increment(:quantity, params[:quantity].to_i)

    if @order_item.save
      redirect_to @open_order, notice: "Product was successfully added to your order."
    else
      redirect_to @open_order, alert: "There was an error adding the product to your order."
    end
  end

  def update
    @product = Product.find(order_item_params[:order_item][:product_id])
    # Use find_or_initialize_by so that if the order item already exists on the order,
    # it will update the quantity instead of creating a new order item.
    @order_item = @open_order.order_items.find_or_initialize_by(product: @product)
    @order_item.increment(:quantity, order_item_params[:order_item][:quantity].to_i)

    if @order_item.quantity <= 0
      @order_item.destroy
      redirect_to @open_order, notice: "Product was successfully removed from your order."
    elsif @order_item.save
      redirect_to @open_order, notice: "Quantity was successfully updated."
    else
      redirect_to @open_order, alert: "There was an error updating the product quantity."
    end
  end

  private

  def order_item_params
    params.require(:order).permit(order_item: [ :product_id, :quantity ])
  end
end
