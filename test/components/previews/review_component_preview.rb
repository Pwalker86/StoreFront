# frozen_string_literal: true

class ReviewComponentPreview < ViewComponent::Preview
  def default
    review = Review.first
    render(ReviewComponent.with_collection([ review ]))
  end
end
