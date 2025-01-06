import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // filesTarget is going to contain the list of input elements we've added
  // files to - in other words, these are the input elements that we're going
  // to submit.
  static targets = ["files"];

  connect() {
    console.log("controller connected!");
  }

  removeFile(event) {
    let fileToRemove = event.target.parentNode
    let fileContainer = fileToRemove.parentNode
    fileContainer.removeChild(fileToRemove)
  }

  addFile(event) {
    // Grab some references for later
    const originalInput = event.target;
    const originalParent = originalInput.parentNode;

    // Create an element that contains our input element
    const selectedFile = document.createElement("div");
    selectedFile.className = "selected-file";
    selectedFile.append(originalInput);
    selectedFile.dataset.fileTarget="fileToUpload"

    // Create label (the visible part of the new input element) with the name of
    // the selected file.
    var labelNode = document.createElement("label");
    var textElement = document.createTextNode(originalInput.files[0].name);
    labelNode.appendChild(textElement);
    selectedFile.appendChild(labelNode);

    // Create button to remove an image before upload
    const removeButton = document.createElement("div")
    removeButton.textContent = "Remove Image"
    removeButton.dataset.action = "click->file#removeFile"
    selectedFile.appendChild(removeButton)
    // Add the selected file to the list of selected files
    this.filesTarget.append(selectedFile);

    // Create a new input field to use going forward
    const newInput = originalInput.cloneNode();

    // Clear the filelist - some browsers maintain the filelist when cloning,
    // others don't
    newInput.value = "";

    // Add it to the DOM where the original input was
    originalParent.append(newInput);
  }
}
