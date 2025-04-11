import { Application } from "@hotwired/stimulus"
import { assert } from "@rails/ujs"
import TooltipController from "controllers/tooltip_controller"

describe("TooltipController", () => {
  beforeEach(() => {
    document.body.innerHTML = `
      <div data-controller="tooltip" data-tooltip-text-value="Test tooltip">
        <button data-tooltip-target="trigger">Hover me</button>
        <div id="anchor-element" data-tooltip-target="anchor"></div>
      </div>
    `

    window.application = Application.start()
    window.application.register("tooltip", TooltipController)
  })

  afterEach(() => {
    document.body.innerHTML = ""
  })

  test("generates a tooltip element when shown", () => {
    const triggerElement = document.querySelector("[data-tooltip-target='trigger']")
    
    // Simulate mouse enter
    triggerElement.dispatchEvent(new Event("mouseenter"))
    
    // Check that tooltip was created and is visible
    const tooltip = document.querySelector(".tooltip")
    assert.ok(tooltip, "Tooltip element should be created")
    assert.equal(tooltip.style.opacity, "1", "Tooltip should be visible")
    assert.equal(tooltip.querySelector("div").textContent, "Test tooltip", "Tooltip content should match text value")
  })

  test("hides tooltip on mouseleave", () => {
    const triggerElement = document.querySelector("[data-tooltip-target='trigger']")
    
    // Show tooltip
    triggerElement.dispatchEvent(new Event("mouseenter"))
    
    // Hide tooltip
    triggerElement.dispatchEvent(new Event("mouseleave"))
    
    // Check tooltip is hidden
    const tooltip = document.querySelector(".tooltip")
    assert.equal(tooltip.style.opacity, "0", "Tooltip should be hidden")
  })

  test("positions tooltip below anchor by default", () => {
    const triggerElement = document.querySelector("[data-tooltip-target='trigger']")
    const anchorElement = document.querySelector("#anchor-element")
    
    // Mock getBoundingClientRect for the anchor
    const anchorRect = { top: 100, bottom: 120, left: 50, right: 150, width: 100, height: 20 }
    anchorElement.getBoundingClientRect = () => anchorRect
    
    // Mock tooltip rect
    const tooltipRect = { width: 200, height: 50 }
    
    // Show tooltip
    triggerElement.dispatchEvent(new Event("mouseenter"))
    
    // Get tooltip and mock its getBoundingClientRect
    const tooltip = document.querySelector(".tooltip")
    tooltip.getBoundingClientRect = () => tooltipRect
    
    // Manually trigger positioning with enough viewport space
    window.innerWidth = 1000
    window.innerHeight = 800
    
    const controller = window.application.getControllerForElementAndIdentifier(
      document.querySelector("[data-controller='tooltip']"),
      "tooltip"
    )
    controller.positionTooltip(tooltip, anchorElement)
    
    // Check position - should be below anchor
    assert.equal(tooltip.style.top, `${anchorRect.bottom + window.scrollY}px`, "Tooltip should be positioned below the anchor")
  })
})