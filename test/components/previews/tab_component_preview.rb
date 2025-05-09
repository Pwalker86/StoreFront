# frozen_string_literal: true

class TabComponentPreview < ViewComponent::Preview
  def default
    render(TabComponent.new(has_content: true)) do
      tag.p "Products"
    end
  end

  def with_no_content
    render(TabComponent.new(has_content: false)) do
      tag.p "Products"
    end
  end
end
