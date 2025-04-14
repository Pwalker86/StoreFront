import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "panel", "trigger", "overlay"];

  connect() {
    // Set up escape key listener
    this.escapeKeyHandler = this.handleEscapeKey.bind(this);
    document.addEventListener("keydown", this.escapeKeyHandler);
    
    // Set up click event on trigger
    this.triggerTarget.addEventListener("click", this.open.bind(this));
  }

  disconnect() {
    document.removeEventListener("keydown", this.escapeKeyHandler);
    if (this.hasTriggerTarget) {
      this.triggerTarget.removeEventListener("click", this.open.bind(this));
    }
  }

  open() {
    // Show the dialogue
    this.containerTarget.classList.remove("hidden");
    
    // Add animation classes
    // this.overlayTarget.classList.add("opacity-50");
    this.panelTarget.classList.add("transform", "transition-all");
    
    // Prevent body scrolling
    document.body.classList.add("overflow-hidden");

    // Focus the first focusable element in the dialogue
    this.focusFirstElement();
  }

  close() {
    this.containerTarget.classList.add("hidden");
    document.body.classList.remove("overflow-hidden");
  }

  handleEscapeKey(event) {
    if (event.key === "Escape" && !this.containerTarget.classList.contains("hidden")) {
      this.close();
    }
  }

  // Focus management for accessibility
  focusFirstElement() {
    const focusableElements = this.panelTarget.querySelectorAll(
      'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
    );
    
    if (focusableElements.length > 0) {
      focusableElements[0].focus();
    }
  }
}
