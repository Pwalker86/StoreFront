import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { url: String, productUrl: String }
  static targets = [ "searchInput", "searchOptionsContainer", "overlay", "searchButton"];

  products = {};

  updateLinkHref(){
    const input = this.searchInputTarget.value
    const link = this.searchButtonTarget
    link.href = this.urlValue + ".json" + `?query=${input}`
  }

  openOverlay(){
    this.overlayTarget.classList.remove("hidden") 
    this.searchOptionsContainerTarget.classList.remove("hidden")
  }

  closeOverlay(){
    this.overlayTarget.classList.add("hidden") 
    this.searchOptionsContainerTarget.classList.add("hidden")
  }

  buildProductsList(products){
    const target = this.searchOptionsContainerTarget
    target.classList.add("displaying-results", "w-50")
    target.classList.remove("hidden")
    target.innerText = ""
    const overlay = document.getElementById("overlay")
    overlay.classList.remove("hidden")
    for (const product of products) {
      const optionLink = document.createElement("a");
      optionLink.classList.add("Search__option")
      optionLink.href = product.href
      optionLink.innerText = product.name
      optionLink.dataset.action = "click->product-search#closeOverlay";
      target.appendChild(optionLink)
    }
  }

  async search(){
    const queryString = new URLSearchParams({query: this.searchInputTarget.value}).toString();
    const searchUrl = `${this.urlValue}?${queryString}`
    const response = await fetch(searchUrl)
    const jsonResponse = await response.json();
    if (jsonResponse.length === 0){
      this.products = [{href: "#", name: "No Results"}];
    } else {
      this.products = jsonResponse;
    }
    this.buildProductsList(this.products);
  }
}
