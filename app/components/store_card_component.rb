# frozen_string_literal: true

class StoreCardComponent < ViewComponent::Base
  def initialize(store:)
    raise "store must be a Store Active Model record!" if !store.is_a?(Store)
    @store = store
  end
end
