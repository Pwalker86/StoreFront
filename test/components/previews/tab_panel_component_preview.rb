# frozen_string_literal: true

class TabPanelComponentPreview < ViewComponent::Preview
  def default
    render(TabPanelComponent.new(has_content: true)) do
      tag.ul do
        safe_join(5.times.map { |i| tag.li("content#{i}") })
      end
    end
  end

  def has_no_content
    render(TabPanelComponent.new(has_content: false)) do
      tag.ul do
        safe_join(5.times.map { |i| tag.li("content#{i}") })
      end
    end
  end
end
