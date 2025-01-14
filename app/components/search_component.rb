# frozen_string_literal: true

class SearchComponent < ViewComponent::Base
  def initialize(url:)
    @url = url
  end
end
