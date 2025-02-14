# frozen_string_literal: true

class ListItemComponent < ViewComponent::Base
  with_collection_parameter :product

  def initialize(product:, link:)
    @name = product[:name]
    @href = product[:href]
    @link = link
  end
end
