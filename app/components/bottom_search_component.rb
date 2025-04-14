# frozen_string_literal: true

class BottomSearchComponent < ViewComponent::Base
  renders_one :trigger

  def initialize(url:, key_events: [], input_placeholder: "Search...")
    raise ArgumentError, "url is required" unless url
    @url = url
    @input_placeholder = input_placeholder
    @key_events = key_events.join(" ")
  end
end
