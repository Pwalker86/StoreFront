# frozen_string_literal: true

class TabControlComponentPreview < ViewComponent::Preview
  def default
    @store = Store.find 1
    render TabControlComponent.new(tab_names: %w[Products Services]) do |component|
      component.with_tab_panels(
        [
          {
            turbo_target: "store_products",
            turbo_path: store_products_path(@store),
            hidden_on_load: false
          },
          {
            turbo_target: "store_services",
            turbo_path: store_services_path(@store),
            hidden_on_load: true
          }
        ],
      )
    end
  end
end
