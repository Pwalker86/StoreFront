import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["offScreen", "menuTrigger"];

  toggleMenu() {
    this.menuTriggerTarget.classList.toggle("fa-x");
    this.menuTriggerTarget.classList.toggle("fa-bars");
    this.offScreenTarget.classList.toggle("open");
  }
}
