import { Controller } from "@hotwired/stimulus";
import Fuse from 'fuse.js'

export default class extends Controller {
  static values = { url: String }
  static targets = [ "searchInput" ];

  products = {};

  connect(){
    this.load();
  }

  load(){
     fetch(this.urlValue)
      .then(response => response.json())
      .then(json => {
        this.products = json
        this.buildProductsContainer();
      })
  }

  buildProductsContainer(){

  }

  search(){
    const fuse = new Fuse(this.products, {
      keys: ['name']
    })
    const result = fuse.search(this.searchInputTarget.value)
  }
}
