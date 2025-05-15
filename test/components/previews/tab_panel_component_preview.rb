# frozen_string_literal: true

class TabPanelComponentPreview < ViewComponent::Preview
  # This should only be used within a TabControlComponent in a slot("tab_panel")
  def default
    @store = Store.find 1
    render TabPanelComponent.new(turbo_target: "store_products", turbo_path: store_products_path(@store), hidden_on_load: false)
  end
end
