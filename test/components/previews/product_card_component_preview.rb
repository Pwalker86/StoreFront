# frozen_string_literal: true

class ProductCardComponentPreview < ViewComponent::Preview
  def default
    render(ProductCardComponent.with_collection(Store.first.products.limit(3)))
  end
end
