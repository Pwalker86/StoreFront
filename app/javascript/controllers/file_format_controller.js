import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="file-format"
export default class extends Controller {
  static targets = ["csvHeaders", "fileSchemaJson", "fileUpload", "fileName"]

  connect() {
    // Set initial state based on selected value when the page loads
    this.update()
    
    // Add event listener for file selection
    if (this.hasFileUploadTarget) {
      this.fileUploadTarget.addEventListener('change', this.updateFileName.bind(this))
    }
  }
  
  updateFileName() {
    if (this.hasFileNameTarget && this.fileUploadTarget.files.length > 0) {
      this.fileNameTarget.textContent = this.fileUploadTarget.files[0].name
    }
  }

  update() {
    const selectedFormat = document.querySelector('select[name*="[type]"]').value
    
    if (selectedFormat === "CsvPartner") {
      this.csvHeadersTarget.classList.remove("hidden")
      this.fileSchemaJsonTarget.classList.add("hidden")
    } else if (selectedFormat === "JsonPartner") {
      this.csvHeadersTarget.classList.add("hidden")
      this.fileSchemaJsonTarget.classList.remove("hidden")
    }
  }
}
