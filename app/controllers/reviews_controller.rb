class ReviewsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    store = Store.find review_params[:store_id]
    review = store.reviews.new(review_params.except(:store_id))
    respond_to do |format|
      if review.save!
        format.html { redirect_to store, notice: "Your review has been created!" }
      else
        format.html { redirect_to store, alert: "Something went wrong with your review" }
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

  def review_params
    params.expect(review: [ :title, :body, :rating, :store_id ])
  end
end
