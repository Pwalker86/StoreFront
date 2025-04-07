import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="file-format"
export default class extends Controller {
  static targets = ["csvHeaders", "fileSchemaJson"];
  
  connect() {
    // Initialize the visibility of the targets based on the selected format
    const selectedFormat = this.element.querySelector('select').value;
    this.update({ target: { value: selectedFormat } });
  }

  update(event) {
    const JSON_PARTNER = 'JsonPartner';
    const CSV_PARTNER = 'CsvPartner';
    const selectedFormat = event.target.value;

    if (selectedFormat === CSV_PARTNER) {
      this.showTarget(this.csvHeadersTarget);
      this.hideTarget(this.fileSchemaJsonTarget);
    } else if (selectedFormat === JSON_PARTNER) {
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
