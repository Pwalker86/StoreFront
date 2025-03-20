class CartItemsController < ApplicationController
  def update
    user = EntityLookup.find_entity(cart_item_params[:user_entity], cart_item_params[:user_id])
    @cart = user.cart
    authorize @cart
    product = Product.find(cart_item_params[:product_id])

    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    cart_item.increment(:quantity, cart_item_params[:quantity].to_i)

    if cart_item.quantity <= 0
      cart_item.destroy
      flash_msg = "Product was successfully removed from your order."
    elsif cart_item.save
      flash_msg = "Quantity was successfully updated."
    else
      flash_msg = "There was an error updating the product quantity."
    end

    respond_to do |format|
      format.json
      format.turbo_stream
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_id, :user_entity, :user_id)
  end
end
