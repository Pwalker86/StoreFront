# frozen_string_literal: true

class CarouselComponent < ViewComponent::Base
  def initialize(images:)
    @images = images
  end

  def render?
    @images.any?
  end
end
