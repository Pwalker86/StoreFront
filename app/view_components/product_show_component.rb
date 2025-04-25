# frozen_string_literal: true

class ProductShowComponent < ViewComponent::Base
  renders_one :product_details, ProductDetailsComponent
  renders_one :image_carousel, CarouselComponent
  # renders_one :product_reviews, ProductReviewsComponent

  def initialize(product:)
    @product = product
  end
end
