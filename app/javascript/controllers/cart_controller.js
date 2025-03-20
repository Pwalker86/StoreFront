import { Controller } from "@hotwired/stimulus";
import { fetchPATCHRequest } from "apiHelper";

// Connects to data-controller="cart"
export default class extends Controller {
  static targets = ["toBeUpdated"];
  connect() {}

  update({ params: { url, updateVal, userEntity, userId, itemId } }) {
    let initialValInt = parseInt(this.toBeUpdatedTarget.innerHTML);
    let updateValInt = parseInt(updateVal);
    let updatedValue = initialValInt + updateValInt;

    // Update value for individual item in the cart
    this.toBeUpdatedTarget.innerHTML = updatedValue;

    // Update value for total cart count
    let cartCount = document.getElementById("cart_count");
    cartCount.textContent = parseInt(cartCount.textContent) + updateValInt;

    // update the value on the server
    if (updatedValue === 0) {
      this.toBeUpdatedTarget.closest(".cart-item").remove();
    }
    this.updateServer({ url, updateVal, userEntity, userId, itemId });
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
}
