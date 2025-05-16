import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "panel", "trigger", "overlay"];
  static values = {
    cookieName: String,
    autoOpen: Boolean
  }

  connect() {
    // Set up escape key listener
    this.escapeKeyHandler = this.handleEscapeKey.bind(this);
    document.addEventListener("keydown", this.escapeKeyHandler);
    
    // Set up click event on trigger if it exists
    if (this.hasTriggerTarget) {
      this.triggerTarget.addEventListener("click", this.open.bind(this));
    }
    
    // Check if we should auto-open
    if (this.autoOpenValue && this.hasCookieNameValue) {
      // Only auto-open if the cookie doesn't exist
      if (!this.getCookie(this.cookieNameValue)) {
        // Small delay to ensure DOM is fully loaded
        setTimeout(() => this.open(), 100);
      }
    }
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
    // Set cookie if we have a cookie name
    if (this.hasCookieNameValue) {
      this.setCookie(this.cookieNameValue, "dismissed", 365);
    }
    
    this.containerTarget.classList.add("hidden");
    document.body.classList.remove("overflow-hidden");
  }

  handleEscapeKey(event) {
    if ((event.key === "Escape" || event.key == 27) && !this.containerTarget.classList.contains("hidden")) {
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
  
  // Cookie helpers
  setCookie(name, value, days) {
    const date = new Date();
    if (days === Infinity || days === undefined) {
      // Set to a very distant future date (Jan 1, 2099)
      date.setFullYear(2099, 0, 1);
    } else {
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
    }
    const expires = "; expires=" + date.toUTCString();
    document.cookie = name + "=" + (value || "") + expires + "; path=/; SameSite=Lax";
  }
  
  getCookie(name) {
    const nameEQ = name + "=";
    const ca = document.cookie.split(';');
    for (let i = 0; i < ca.length; i++) {
      let c = ca[i];
      while (c.charAt(0) === ' ') c = c.substring(1, c.length);
      if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
  }
}
