# frozen_string_literal: true

class ProductTagComponent < ViewComponent::Base
  with_collection_parameter :tag

  def initialize(tag:, product:)
    @product = product
    @tag = tag
  end

  def render?
    @tag.present?
  end
end
