# frozen_string_literal: true

class ReviewComponentPreview < ViewComponent::Preview
  def default
    render(ReviewComponent.new(review: "review"))
  end
end
