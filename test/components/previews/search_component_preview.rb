# frozen_string_literal: true

class SearchComponentPreview < ViewComponent::Preview
  def with_default_url
    render(SearchComponent.new(url: "/search"))
  end

  def with_custom_placeholder
    render(SearchComponent.new(url: "/search", input_placeholder: "Find a thing..."))
  end
end
