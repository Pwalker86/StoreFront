import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="carousel"
export default class extends Controller {
  static targets = ["item", "prevButton", "nextButton", "dot", "dots"];
  static values = {
    position: Number,
    default: 0,
    numberOfItems: Number,
    dotIndex: Number,
  };

  /**
   * Initializes the carousel by setting the number of items and showing the first slide.
   */
  connect() {
    this.numberOfItemsValue = this.itemTargets.length;
    this.showSlide(0);
  }

  /**
   * Hides all slides by replacing the visible class with the hidden class.
   * Removes the selected-dot class from all dots.
   */
  hideAllSlides() {
    this.itemTargets.forEach((item) =>
      item.classList.replace("carousel-item-visible", "carousel-item-hidden"),
    );
    this.dotTargets.forEach((dot) => dot.classList.remove("selected-dot"));
  }

  /**
   * Shows the slide at the given index and updates the dot indicators.
   * @param {number} index - The index of the slide to show.
   */
  showSlide(index) {
    this.hideAllSlides();
    this.positionValue = index;
    this.itemTargets[index].classList.add("carousel-item-visible");
    this.dotTargets[index].classList.add("selected-dot");
    this.dotTargets[index].checked = true;
  }

  /**
   * Moves to the next slide in the carousel.
   */
  handleMoveToNextSlide() {
    const nextIndex = (this.positionValue + 1) % this.numberOfItemsValue;
    this.showSlide(nextIndex);
  }

  /**
   * Moves to the previous slide in the carousel.
   */
  handleMoveToPrevSlide() {
    const prevIndex =
      (this.positionValue - 1 + this.numberOfItemsValue) %
      this.numberOfItemsValue;
    this.showSlide(prevIndex);
  }

  /**
   * Handles the click event on a dot indicator to show the corresponding slide.
   * @param {Event} e - The click event.
   */
  handleDotClick(e) {
    const index = +e.target.dataset.carouselDotIndexValue;
    this.showSlide(index);
  }
}

