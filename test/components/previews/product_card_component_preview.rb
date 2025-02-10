# frozen_string_literal: true

class ProductCardComponentPreview < ViewComponent::Preview
  def default
    render(ProductCardComponent.new(title: "title", image: "image", description: "description", buttonText: "buttonText", cardItem: Product.first))
  end
end
