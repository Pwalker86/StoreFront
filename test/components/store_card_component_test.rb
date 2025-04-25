# frozen_string_literal: true

require "test_helper"

class StoreCardComponentTest < ActiveSupport::TestCase
  include Phlex::Testing::Rails::ViewComponent

  test "renders the store card component" do
    store = stores(:one)
    component = render(Components::StoreCardComponent.new(store: store))

    # Test that the component renders the store name
    assert_includes component.to_s, store.name

    # Test that it includes the 'Shop Now' button
    assert_includes component.to_s, "Shop Now"

    # Test that it includes the link to the store
    assert_includes component.to_s, "/stores/#{store.id}"
  end

  test "raises an error when initialized with an invalid store" do
    assert_raises RuntimeError do
      Components::StoreCardComponent.new(store: "Not a store")
    end
  end
end
