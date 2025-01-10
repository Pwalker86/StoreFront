class CartUpdateService
  def initialize(user_entity_param, user_id, product_id, quantity)
    safe_constants = {
      "Guest": Guest,
      "User": User
    }
    @user_entity_class = safe_constants[user_entity_param.to_sym]
    @user_id = user_id
    @product_id = product_id
    @quantity = quantity
  end

  def call
    cart = @user_entity_class.find(@user_id).cart
    product = Product.find(@product_id)

    cart_item = cart.cart_items.find_or_initialize_by(product: product)
    cart_item.increment(:quantity, @quantity.to_i)

    if cart_item.quantity <= 0
      cart_item.destroy
      { status: :removed, message: "Product was successfully removed from your order." }
    elsif cart_item.save
      { status: :updated, message: "Quantity was successfully updated." }
    else
      { status: :error, message: "There was an error updating the product quantity." }
    end
  end
end
