class ReviewsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    reviewable = review_find_params[:reviewable_class].constantize.find(review_find_params[:reviewable_id])
    review = reviewable.reviews.new(review_params)
    respond_to do |format|
      if review.save!
        format.html { redirect_to reviewable, notice: "Your review has been created!" }
      else
        format.html { redirect_to reviewable, alert: "Something went wrong with your review" }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  # separate param function so I don't have to exempt these when creating the review
  def review_find_params
    params.expect(review: [ :reviewable_id, :reviewable_class ])
  end

  def review_params
    params.expect(review: [ :title, :body, :rating ])
  end
end
