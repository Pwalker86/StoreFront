# frozen_string_literal: true

class AccordianComponent < ViewComponent::Base
  def initialize(summaryText:, detailText:)
    @summaryText = summaryText
    @detailText = detailText
  end
end
