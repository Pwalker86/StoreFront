# frozen_string_literal: true

class ProductTagComponentPreview < ViewComponent::Preview
  def default
    product = Product.find 2
    render(ProductTagComponent.with_collection(product.tag_list, product: product))
  end
end
