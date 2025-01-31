import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { url: String };
  static targets = [
    "searchInput",
    "searchOptionsContainer",
    "overlay",
    "searchButton",
  ];

  noResults = [{ href: "#", name: "No Results" }];
  products = {};

  handleSearchKeyup(event) {
    event.preventDefault();
    const lastItem = this.searchOptionsContainerTarget.lastChild;
    if (lastItem) {
      lastItem.focus();
    }
  }

  handleSearchKeydown(event) {
    event.preventDefault();
    const firstItem = this.searchOptionsContainerTarget.firstChild;
    if (firstItem) {
      firstItem.focus();
    }
  }

  handleNavigateUp(event) {
    event.preventDefault();
    const items = Array.from(this.searchOptionsContainerTarget.children);
    const currentIndex = items.indexOf(document.activeElement);
    const nextIndex = (currentIndex - 1 + items.length) % items.length;
    items[nextIndex].focus();
  }

  handleNavigateDown(event) {
    event.preventDefault();
    const items = Array.from(this.searchOptionsContainerTarget.children);
    const currentIndex = items.indexOf(document.activeElement);
    const nextIndex = (currentIndex + 1) % items.length;
    items[nextIndex].focus();
  }

  updateLinkHref() {
    const queryString = new URLSearchParams({
      query: this.searchInputTarget.value,
    }).toString();
    const searchUrl = `${this.urlValue}?${queryString}`;
    const link = this.searchButtonTarget;
    link.href = searchUrl;
  }

  closeOverlay() {
    this.overlayTarget.classList.add("hidden");
    this.searchOptionsContainerTarget.classList.add("hidden");
  }

  focusOption(event) {
    event.target.focus();
  }

  buildDropdownEntry(option) {
    const optionLink = document.createElement("a");
    optionLink.classList.add("Search__option");
    optionLink.href = option.href;
    optionLink.innerText = option.name;
    optionLink.dataset.action =
      "click->search-component#closeOverlay mouseover->search-component#focusOption";
    return optionLink;
  }

  buildProductsList(products) {
    const target = this.searchOptionsContainerTarget;
    target.classList.add("displaying-results", "w-50");
    target.classList.remove("hidden");
    target.innerText = "";
    this.overlayTarget.classList.remove("hidden");
    for (const product of products) {
      const option = this.buildDropdownEntry(product);
      target.appendChild(option);
    }
  }

  // TODO: refactor to watch searchInput value changed with an abort controller
  async search() {
    const queryString = new URLSearchParams({
      query: this.searchInputTarget.value,
    }).toString();
    const searchUrl = `${this.urlValue}.json?${queryString}`;
    const response = await fetch(searchUrl);
    const jsonResponse = await response.json();
    this.products = jsonResponse.length ? jsonResponse : this.noResults;
    this.buildProductsList(this.products);
  }
}
