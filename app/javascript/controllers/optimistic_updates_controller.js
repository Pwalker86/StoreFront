import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="optimistic-updates"
export default class extends Controller {
  static targets = ["toBeUpdated", "cartCount"];
  connect() {
    debugger;
  }

  update({ params: { updateVal } }) {
    let initialValInt = parseInt(this.toBeUpdatedTarget.innerHTML);
    let cartCountInitialValInt = parseInt(this.cartCountTarget.innerHTML);
    let updateValInt = parseInt(updateVal);
    this.toBeUpdatedTarget.innerHTML = initialValInt + updateValInt;
    this.cartCountTarget.innerHTML = cartCountInitialValInt + updateValInt;
  }

  async call({ params: { url, updateVal, userEntity, userId, itemId } }) {
    const headers = new Headers();
    const csrf = this.getMetaValue("csrf-token");
    headers.append("Content-Type", "application/json");
    headers.append("X-CSRF-Token", csrf);
    try {
      await fetch(url, {
        method: "PATCH",
        headers: headers,
        body: JSON.stringify({
          cart_item: {
            quantity: updateVal,
            user_entity: userEntity,
            user_id: userId,
            product_id: itemId,
          },
        }),
      });
    } catch (error) {
      console.error(error);
    }
  }

  getMetaValue(name) {
    const element = document.querySelector(`meta[name="${name}"]`);
    return element.getAttribute("content");
  }
}
