# frozen_string_literal: true

class ReviewComponent < ViewComponent::Base
  def initialize(review:)
    @review = review
  end

  def render?
    @review.persisted?
  end
end
