# frozen_string_literal: true

class CardComponentPreview < ViewComponent::Preview
  def default
    render(CardComponent.new(title: "title", image: "image", description: "description", isLink: "isLink", buttonText: "buttonText", cardItem: Product.first))
  end
end
