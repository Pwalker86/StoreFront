# frozen_string_literal: true

class SearchComponent < ViewComponent::Base
  def initialize(url:, input_placeholder: "Search...")
    @url = url
    @input_placeholder = input_placeholder
  end
end
