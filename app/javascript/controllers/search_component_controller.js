import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { url: String, productUrl: String }
  static targets = [ "searchInput", "searchOptionsContainer", "overlay", "searchButton"];

  noResults = [{href: "#", name: "No Results"}]
  products = {};

  clickSearch(){
    this.searchButtonTarget.click()
  }

  updateLinkHref(){
    const queryString = new URLSearchParams(
      {
        query: this.searchInputTarget.value
      }
    ).toString();
    const searchUrl = `${this.urlValue}?${queryString}`
    const link = this.searchButtonTarget
    link.href = searchUrl
  }

  closeOverlay(){
    this.overlayTarget.classList.add("hidden") 
    this.searchOptionsContainerTarget.classList.add("hidden")
  }

  buildDropdownEntry(option){
    const optionLink = document.createElement("a");
    optionLink.classList.add("Search__option")
    optionLink.href = option.href
    optionLink.innerText = option.name
    optionLink.dataset.action = "click->product-search#closeOverlay";

    return optionLink;
  }

  buildProductsList(products){
    const target = this.searchOptionsContainerTarget
    target.classList.add("displaying-results", "w-50")
    target.classList.remove("hidden")
    target.innerText = ""
    this.overlayTarget.classList.remove("hidden") 
    for (const product of products) {
      const option = this.buildDropdownEntry(product)
      target.appendChild(option)
    }
  }

  async search(){
    const queryString = new URLSearchParams({query: this.searchInputTarget.value}).toString();
    const searchUrl = `${this.urlValue}.json?${queryString}`
    const response = await fetch(searchUrl)
    const jsonResponse = await response.json();
    this.products = jsonResponse.length === 0 
      ? this.noResults 
      : jsonResponse;
    this.buildProductsList(this.products);
  }
}
