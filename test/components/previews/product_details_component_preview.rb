# frozen_string_literal: true

class ProductDetailsComponentPreview < ViewComponent::Preview
  def default
    p = Product.last
    render(ProductDetailsComponent.new(product: p))
  end
end
