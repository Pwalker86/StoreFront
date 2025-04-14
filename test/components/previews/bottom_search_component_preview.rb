# frozen_string_literal: true

class BottomSearchComponentPreview < ViewComponent::Preview
  def with_default_trigger
    render(BottomSearchComponent.new(url: "/search"))
  end

  def with_custom_placeholder
    render(BottomSearchComponent.new(url: "/search", input_placeholder: "Find what you're looking for..."))
  end

  def with_custom_trigger
    render(BottomSearchComponent.new(url: "/search", input_placeholder: "Find what you're looking for...")) do
      tag.p 'Click to Search'
    end
  end
end
