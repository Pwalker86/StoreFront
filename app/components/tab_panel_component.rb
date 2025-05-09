# frozen_string_literal: true

class TabPanelComponent < ViewComponent::Base
  def initialize(has_content:)
    @has_content = has_content
  end

  def call
    tag.div(data: { tabs_target: "panel" }) do
      content
    end
  end

  def render?
    !!@has_content
  end
end
