class StoreReviewsController < ApplicationController
  def index
    @store = Store.find params[:store_id]
    @pagy_reviews, @reviews = pagy(@store.reviews.order(created_at: :desc), limt: 6, page_param: :reviews_page)
  end

  def new
    @store = Store.find params[:store_id]
    @review = @store.reviews.new
  end

  def create
    @store = Store.find params[:store_id]
    @review = @store.reviews.new(review_params)
    if @review.save
      @pagy_reviews, @reviews = pagy(@store.reviews.order(created_at: :desc), limt: 6, page_param: :reviews_page)
      respond_to do |format|
        format.html { redirect_to @store, notice: "Your review has been created!" }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @store = Store.find params[:store_id]
    @review = @store.reviews.find params[:id]
  end

  def update
    @store = Store.find params[:store_id]
    @review = @store.reviews.find params[:id]
    if @review.update(review_params)
      @pagy_reviews, @reviews = pagy(@store.reviews.order(created_at: :desc), limt: 6, page_param: :reviews_page)
      respond_to do |format|
        format.html { redirect_to @store, notice: "Your review has been updated!" }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def review_params
     params.expect(review: [ :title, :body ])
  end
end
