import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["storeReviewForm", "reviewFormTrigger"];

  toggleReviewForm() {
    if (this.storeReviewFormTarget.classList.contains("hidden")) {
      this.reviewFormTriggerTarget.innerText = "Close Form";
      this.storeReviewFormTarget.classList.remove("hidden");
    } else {
      this.reviewFormTriggerTarget.innerText = "Add Your Review";
      this.storeReviewFormTarget.classList.add("hidden");
    }
  }
}
