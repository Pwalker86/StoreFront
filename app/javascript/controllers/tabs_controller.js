import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = ["tab", "panel"]

  connect() {
    // Set initial active state on first tab when component loads
    if (this.tabTargets.length > 0 && this.panelTargets.length > 0) {
      this.activate(this.tabTargets[0], this.panelTargets[0])
    }
  }

  change(event) {
    // Prevent default behavior (like scrolling if it was a link)
    event.preventDefault()
    
    // Find the index of the clicked tab
    const clickedTab = event.currentTarget
    const index = this.tabTargets.indexOf(clickedTab)
    
    // Only proceed if we found a valid target tab
    if (index !== -1) {
      // Deactivate all tabs and panels first
      this.tabTargets.forEach((tab, i) => {
        const panel = this.panelTargets[i]
        this.deactivate(tab, panel)
      })
      
      // Activate the clicked tab and its corresponding panel
      this.activate(clickedTab, this.panelTargets[index])
    }
  }

  // Helper to activate a tab/panel pair
  activate(tab, panel) {
    tab.classList.add("border-indigo-600", "text-indigo-600")
    tab.classList.remove("border-transparent", "text-gray-500", "hover:text-gray-700", "hover:border-gray-300")
    tab.setAttribute("aria-selected", "true")
    
    panel.classList.remove("hidden")
  }

  // Helper to deactivate a tab/panel pair
  deactivate(tab, panel) {
    tab.classList.remove("border-indigo-600", "text-indigo-600")
    tab.classList.add("border-transparent", "text-gray-500", "hover:text-gray-700", "hover:border-gray-300")
    tab.setAttribute("aria-selected", "false")
    
    panel.classList.add("hidden")
  }
}