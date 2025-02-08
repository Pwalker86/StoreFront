# frozen_string_literal: true

class ProductDetailsComponent < ViewComponent::Base
  def initialize(product:)
    @product = product
  end
end
