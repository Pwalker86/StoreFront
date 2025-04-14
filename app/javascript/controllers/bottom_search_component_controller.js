import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { url: String };
  static targets = [
    "searchInput",
    "searchOptionsContainer",
    "searchButton",
    "searchContainer",
    "trigger",
    "overlay"
  ];

  noResults = [{ href: "#", name: "No Results" }];
  errorResponse = [
    { href: "#", name: "Error fetching results. Site Admin has been notified" },
  ];
  seeMore = [{ href: "#", name: "See More Results..." }];
  products = {};

  connect() {
    console.log("bottom-search-component controller connected!");
  }

  toggleSearch() {
    const isOpening = this.searchContainerTarget.classList.toggle("translate-y-full");
    this.overlayTarget.classList.toggle("hidden", isOpening);
    
    // Focus the search input when opened
    if (!isOpening) {
      setTimeout(() => {
        this.searchInputTarget.focus();
      }, 300); // Delay to allow animation to complete
    }
  }

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

  closeSearch() {
    this.searchContainerTarget.classList.add("translate-y-full");
    this.overlayTarget.classList.add("hidden");
  }

  focusOption(event) {
    event.target.focus();
  }

  buildDropdownEntry(option) {
    const optionLink = document.createElement("a");
    optionLink.classList.add(
      "block",
      "px-4",
      "py-2",
      "border-b",
      "border-gray-200",
      "bg-white",
      "last:border-none",
      "hover:bg-indigo-50",
      "focus:bg-indigo-50",
      "focus:outline-none",
      "transition-colors",
      "duration-150",
      "text-gray-700",
    );
    optionLink.href = option.href;
    
    // Create a container for product name and store name
    const contentContainer = document.createElement("div");
    
    // Create and style product name element
    const productName = document.createElement("div");
    productName.classList.add("text-gray-800");
    productName.innerText = option.name;
    contentContainer.appendChild(productName);
    
    // Create and style store name element if it exists
    if (option.store_name) {
      const storeName = document.createElement("div");
      storeName.classList.add("text-xs", "text-gray-500", "mt-1");
      storeName.innerText = option.store_name;
      contentContainer.appendChild(storeName);
    }
    
    // Add the content container to the link
    optionLink.appendChild(contentContainer);
    
    optionLink.dataset.action =
      "click->bottom-search-component#closeSearch mouseover->bottom-search-component#focusOption";
    
    if (option.name === "See More Results...") {
      optionLink.classList.add("text-indigo-600", "font-medium");
    } else if (option.name === "No Results") {
      optionLink.classList.add("text-gray-500", "italic");
    } else if (option.name.includes("Error fetching")) {
      optionLink.classList.add("text-red-600");
    }
    return optionLink;
  }

  buildProductsList(products) {
    const target = this.searchOptionsContainerTarget;
    target.classList.add("w-full");
    target.innerText = "";
    for (const product of products) {
      const option = this.buildDropdownEntry(product);
      target.appendChild(option);
    }
  }

  async search() {
    const queryString = new URLSearchParams({
      query: this.searchInputTarget.value,
    }).toString();
    const searchUrl = `${this.urlValue}.json?${queryString}`;
    
    // Only perform search if query has content
    if (this.searchInputTarget.value.trim().length === 0) {
      this.searchOptionsContainerTarget.innerText = "";
      return;
    }
    
    try {
      const response = await fetch(searchUrl);
      const jsonResponse = await response.json();
      this.handleSearchResponse(jsonResponse, queryString);
    } catch (error) {
      console.error(error);
      this.handleSearchResponse(this.errorResponse, queryString);
    }
  }

  handleSearchResponse(jsonResponse, queryString) {
    if (jsonResponse.length === 0) {
      this.products = this.noResults;
    } else if (jsonResponse === this.errorResponse) {
      this.products = jsonResponse;
    } else {
      this.products =
        jsonResponse.length > 5
          ? jsonResponse.slice(0, 5).concat(this.seeMore)
          : jsonResponse;
      if (jsonResponse.length > 5) {
        this.seeMore[0].href = `${this.urlValue}?${queryString}`;
      }
    }
    this.buildProductsList(this.products);
  }
}