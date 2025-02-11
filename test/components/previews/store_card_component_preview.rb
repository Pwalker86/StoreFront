# frozen_string_literal: true

class StoreCardComponentPreview < ViewComponent::Preview
  def default
    render(StoreCardComponent.new(store: Store.first, wrapper_classes: "mt-1 mx-2"))
  end
end
