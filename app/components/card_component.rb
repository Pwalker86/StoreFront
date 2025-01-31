# frozen_string_literal: true

class CardComponent < ViewComponent::Base
  def initialize(title:, image:, description:, isLink:, buttonText:, cardItem:)
    @title = title
    @image = image
    @title = title
    @description = description
    @isLink = isLink
    @buttonText = buttonText
    @cardItem = cardItem
  end
end
