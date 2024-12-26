import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["reviewForm", "reviewFormTrigger"];

  toggleReviewForm() {
    debugger;
    if (this.reviewFormTarget.classList.contains("hidden")) {
      this.reviewFormTriggerTarget.innerText = "Close Form";
      this.reviewFormTarget.classList.remove("hidden");
    } else {
      this.reviewFormTriggerTarget.innerText = "Add Your Review";
      this.reviewFormTarget.classList.add("hidden");
    }
  }
}
