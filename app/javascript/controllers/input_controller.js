import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="input"
export default class extends Controller {
  static values = { url: String };
  static targets = ["input"];

  connect() {
    this.focusInput();
  }

  focusInput() {
    this.inputTarget.focus();
  }

  // TODO: keeping this for now in case I want to add tags via stimulus in the future
  // addTag() {
  //   this.postTag();
  // }
  //
  // postTag() {
  //   const tag = this.inputTarget.value;
  //   const data = JSON.stringify({ tag: tag });
  //   const headers = new Headers();
  //   const csrf = this.getMetaValue("csrf-token");
  //   headers.append("Content-Type", "application/json");
  //   headers.append("X-CSRF-Token", csrf);
  //   fetch(this.urlValue, {
  //     method: "POST",
  //     headers: headers,
  //     body: data,
  //   })
  //     .then((response) => response.json())
  //     .then((data) => {
  //       console.log("Success:", data);
  //       this.inputTarget.value = ""; // Clear the input field
  //     })
  //     .catch((error) => {
  //       console.error("Error:", error);
  //     });
  // }
  //
  // getMetaValue(name) {
  //   const element = document.querySelector(`meta[name="${name}"]`);
  //   return element.getAttribute("content");
  // }
}
