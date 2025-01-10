# TODO: This needs to be moved over to a new ProductReviewsController like has already been done with StoreReviewsController
class ReviewsController < ApplicationController
  def index
  end

  def show
  end

  def new
    # @reviewable = params[:reviewable_class].constantize.find(params[:reviewable_id])
  end

  def create
    # reviewable = review_find_params[:reviewable_class].constantize.find(review_find_params[:reviewable_id])
    # review = reviewable.reviews.new(review_params)
    # respond_to do |format|
    #   path = reviewable.is_a?(Product) ? store_product_path([ reviewable.store, reviewable ]) : reviewable
    #   if review.save
    #     format.html { redirect_to path, notice: "Your review has been created!" }
    #     format.turbo_stream
    #   else
    #     format.html { redirect_to path, alert: "Something went wrong with your review" }
    #     format.json { render json: review.errors, status: :unprocessable_entity }
    #   end
    # end
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
