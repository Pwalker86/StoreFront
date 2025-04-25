# frozen_string_literal: true

class ReviewComponent < ViewComponent::Base
  attr_reader :review
  renders_many :links, LinkComponent

  def initialize(review:)
    @review = review
  end

  def render?
    @review.persisted?
  end
end
