# frozen_string_literal: true

class TooltipComponent < ViewComponent::Base
  attr_reader :tooltip_text

  def initialize(tooltip_text:)
    @tooltip_text = tooltip_text
  end
end
