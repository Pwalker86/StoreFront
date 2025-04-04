import { Controller } from "@hotwired/stimulus";
import { fetchPATCHRequest } from "apiHelper";

// Connects to data-controller="cart"
export default class extends Controller {
  static targets = ["toBeUpdated"];
  connect() {}

  // TODO: need to update cart item price as well
  update({
    params: { url, updateVal, userEntity, userId, itemId, itemPrice },
  }) {
    let initialValInt = parseInt(this.toBeUpdatedTarget.innerHTML);
    let updateValInt = parseInt(updateVal);
    let updatedValue = initialValInt + updateValInt;

    // Update value for individual item in the cart
    this.toBeUpdatedTarget.innerHTML = updatedValue;

    // Update value for total cart count
    this.updateCartCount(updateValInt);
    this.updateCartItemPrice(itemPrice, itemId);
    this.updateCartTotalPrice(itemPrice);

    // Remove from the cart if the new value will be 0
    if (updatedValue === 0) {
      this.toBeUpdatedTarget.closest(".cart-item").remove();
    }

    // update the value on the server
    this.updateServer({ url, updateVal, userEntity, userId, itemId });
  }

  parseMoney(price) {
    return parseFloat(price.replace(/[^0-9.-]+/g, ""));
  }

  async updateServer({ url, updateVal, userEntity, userId, itemId }) {
    try {
      await fetchPATCHRequest(url, {
        cart_item: {
          quantity: updateVal,
          user_entity: userEntity,
          user_id: userId,
          product_id: itemId,
        },
      });
    } catch (error) {
      console.error(error);
    }
  }

  updateCartCount(updateValInt) {
    let cartCount = document.getElementById("cart_count");
    cartCount.textContent = parseInt(cartCount.textContent) + updateValInt;
  }

  updateCartItemPrice(itemPrice, itemId) {
    let cartItemPrice = document.getElementById(`item_${itemId}_price`);
    const parsedPrice = this.parseMoney(cartItemPrice.textContent);
    const newPrice = parsedPrice + itemPrice;
    cartItemPrice.textContent = newPrice.toLocaleString("en-US", {
      style: "currency",
      currency: "USD",
    });
  }

  updateCartTotalPrice(itemPrice) {
    let cartTotalPrice = document.getElementById("cart_total_price");
    const parsedTotalPrice = this.parseMoney(cartTotalPrice.textContent);
    const newTotalPrice = parsedTotalPrice + itemPrice;
    cartTotalPrice.textContent = newTotalPrice.toLocaleString("en-US", {
      style: "currency",
      currency: "USD",
    });
  }
}
