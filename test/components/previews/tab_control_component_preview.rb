# frozen_string_literal: true

class TabControlComponentPreview < ViewComponent::Preview
  def default
    render(TabControlComponent.new()) do
    end
  end
end
