# frozen_string_literal: true

class StoreCardComponent < ViewComponent::Base
  def initialize(store:, wrapper_classes: "")
    raise "store must be a Store Active Model record!" if !store.is_a?(Store)
    @store = store
    @wrapper_classes = wrapper_classes
  end
end
