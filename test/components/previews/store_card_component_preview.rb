# frozen_string_literal: true

class StoreCardComponentPreview < ViewComponent::Preview
  def default
    render(StoreCardComponent.new(store: Store.first))
  end
end
