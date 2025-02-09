class StoreReviewsController < ApplicationController
  def index
    @store = Store.find params[:store_id]
    @pagy, @reviews = pagy(@store.reviews.ordered)
  end

  def show
  end

  def new
    @store = Store.find params[:store_id]
  end

  def create
    @store = Store.find params[:store_id]
    @review = @store.reviews.new(review_params)
    if @review.save
      @pagy, @reviews = pagy(@store.reviews.ordered)
      respond_to do |format|
        format.html { redirect_to @store, notice: "Your review has been created!" }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
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
     params.expect(review: [ :title, :body ])
  end
end
