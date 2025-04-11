import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["anchor", "trigger"];
  static values = { text: String };

  connect() {
    this.tooltipElement = null;
    this.visible = false;
    
    // Event listeners for showing/hiding tooltip
    if (this.hasTriggerTarget) {
      this.triggerTarget.addEventListener("click", this.show.bind(this));
      // this.triggerTarget.addEventListener("mouseenter", this.show.bind(this));
      this.triggerTarget.addEventListener("mouseleave", this.hide.bind(this));
      // this.triggerTarget.addEventListener("focus", this.show.bind(this));
      // this.triggerTarget.addEventListener("blur", this.hide.bind(this));
    }
  }

  disconnect() {
    // Clean up event listeners and remove tooltip element
    if (this.hasTriggerTarget) {
      this.triggerTarget.removeEventListener("click", this.show.bind(this));
      // this.triggerTarget.removeEventListener("mouseenter", this.show.bind(this));
      this.triggerTarget.removeEventListener("mouseleave", this.hide.bind(this));
      // this.triggerTarget.removeEventListener("focus", this.show.bind(this));
      // this.triggerTarget.removeEventListener("blur", this.hide.bind(this));
    }
    
    if (this.tooltipElement) {
      document.body.removeChild(this.tooltipElement);
    }
  }

  generateElement() {
    if (this.tooltipElement) return this.tooltipElement;
    
    // Create tooltip container
    const tooltip = document.createElement("div");
    tooltip.classList.add("tooltip");
    tooltip.style.position = "absolute";
    tooltip.style.zIndex = "1000";
    tooltip.style.backgroundColor = "#333";
    tooltip.style.color = "#fff";
    tooltip.style.padding = "8px 12px";
    tooltip.style.borderRadius = "4px";
    tooltip.style.fontSize = "14px";
    tooltip.style.pointerEvents = "none";
    tooltip.style.opacity = "0";
    tooltip.style.transition = "opacity 0.3s";
    tooltip.style.maxWidth = "250px";
    tooltip.style.boxShadow = "0 2px 5px rgba(0,0,0,0.2)";
    
    // Create arrow element
    const arrow = document.createElement("div");
    arrow.style.position = "absolute";
    arrow.style.width = "0";
    arrow.style.height = "0";
    arrow.style.borderLeft = "6px solid transparent";
    arrow.style.borderRight = "6px solid transparent";
    arrow.style.borderBottom = "6px solid #333";
    arrow.style.top = "-6px";
    arrow.style.left = "10px";
    
    tooltip.appendChild(arrow);
    
    // Add content
    const content = document.createElement("div");
    content.textContent = this.textValue;
    tooltip.appendChild(content);
    
    // Add to document but keep hidden
    document.body.appendChild(tooltip);
    this.tooltipElement = tooltip;
    this.arrowElement = arrow;
    
    return tooltip;
  }
  
  show() {
    if (this.visible) return;
    
    const tooltip = this.generateElement();
    const anchor = this.hasAnchorTarget ? this.anchorTarget : this.triggerTarget;
    
    if (!anchor) return;
    
    this.positionTooltip(tooltip, anchor);
    tooltip.style.opacity = "1";
    this.visible = true;
  }
  
  hide() {
    if (!this.visible || !this.tooltipElement) return;
    
    this.tooltipElement.style.opacity = "0";
    this.visible = false;
  }
  
  positionTooltip(tooltip, anchor) {
    // Get positioning information
    const anchorRect = anchor.getBoundingClientRect();
    const tooltipRect = tooltip.getBoundingClientRect();
    const viewportWidth = window.innerWidth;
    const viewportHeight = window.innerHeight;
    
    // Calculate positions
    let top = anchorRect.bottom + window.scrollY;
    let left = anchorRect.left + window.scrollX;
    let arrowLeft = 10;
    
    // Check vertical position - if not enough space below, position above
    if (top + tooltipRect.height > viewportHeight + window.scrollY) {
      top = anchorRect.top - tooltipRect.height - 6 + window.scrollY;
      // Flip arrow to point down
      this.arrowElement.style.top = "auto";
      this.arrowElement.style.bottom = "-6px";
      this.arrowElement.style.borderTop = "6px solid #333";
      this.arrowElement.style.borderBottom = "none";
    } else {
      // Reset arrow to point up
      this.arrowElement.style.top = "-6px";
      this.arrowElement.style.bottom = "auto";
      this.arrowElement.style.borderBottom = "6px solid #333";
      this.arrowElement.style.borderTop = "none";
    }
    
    // Check horizontal position - if too far right, align right edge
    if (left + tooltipRect.width > viewportWidth) {
      const rightAlignedLeft = viewportWidth - tooltipRect.width - 10;
      arrowLeft = Math.max(5, Math.min(tooltipRect.width - 15, 
        anchorRect.left + (anchorRect.width / 2) - rightAlignedLeft));
      left = rightAlignedLeft;
    }
    
    // Position arrow
    this.arrowElement.style.left = `${arrowLeft}px`;
    
    // Apply final position
    tooltip.style.top = `${top}px`;
    tooltip.style.left = `${left}px`;
  }
}
