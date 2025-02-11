# frozen_string_literal: true

class ProductDetailsComponentPreview < ViewComponent::Preview
  def default
    p = Product.find 3
    render(ProductDetailsComponent.new(product: p))
  end
end
