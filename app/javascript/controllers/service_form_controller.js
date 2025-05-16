import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["staticFields", "dynamicFields"]

  connect() {
    this.toggleFields();
  }

  toggleFields() {
    const selectedType = this.element.querySelector("select[name*='type']").value;
    
    if (selectedType === "StaticService") {
      this.staticFieldsTarget.classList.remove("hidden");
      this.dynamicFieldsTarget.classList.add("hidden");
    } else if (selectedType === "DynamicService") {
      this.staticFieldsTarget.classList.add("hidden");
      this.dynamicFieldsTarget.classList.remove("hidden");
    }
  }
}