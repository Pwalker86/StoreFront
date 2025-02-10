# frozen_string_literal: true

class ProductCardComponent < ViewComponent::Base
  # renders_one :description, ProductCardDescriptionComponent
  # renders_one :image, ProductCardImageComponent

  def initialize(title:, image:, description:, buttonText:, cardItem:)
    @title = title
    @image = image
    @title = title
    @description = description
    @buttonText = buttonText
    @cardItem = cardItem
  end
end
