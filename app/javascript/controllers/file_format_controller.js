import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="file-format"
export default class extends Controller {
  static targets = ["csvHeaders", "fileSchemaJson"];

  update(event) {
    const selectedFormat = event.target.value;

    if (selectedFormat === "csv") {
      this.showTarget(this.csvHeadersTarget);
      this.hideTarget(this.fileSchemaJsonTarget);
    } else if (selectedFormat === "json") {
      this.hideTarget(this.csvHeadersTarget);
      this.showTarget(this.fileSchemaJsonTarget);
    } else {
      this.hideTarget(this.csvHeadersTarget);
      this.hideTarget(this.fileSchemaJsonTarget);
    }
  }

  showTarget(target) {
    target.classList.remove("hidden");
  }

  hideTarget(target) {
    target.classList.add("hidden");
  }
}
