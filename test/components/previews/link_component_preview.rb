# frozen_string_literal: true

class LinkComponentPreview < ViewComponent::Preview
  def default
    render(LinkComponent.new(text: "text", path: "path", dataset: "dataset"))
  end
end
