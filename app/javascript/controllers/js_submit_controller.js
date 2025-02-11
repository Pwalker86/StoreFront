import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="js-submit"
export default class extends Controller {
  static targets = ["form", "input"];

  confirmAnswer = null;

  connect() {
    console.log("js-submit controller connected!");
  }

  jsSubmit(event) {
    event.preventDefault();

    if (this.inputTarget.files.length == 0) {
      this.confirmAnswer = confirm(
        "Are you sure you want to submit without any files? Your store cannot be featured without an image",
      );
    } else {
      this.formTarget.submit();
    }

    if (this.confirmAnswer) this.formTarget.submit();
  }
}
