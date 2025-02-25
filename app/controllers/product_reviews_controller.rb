class ProductReviewsController < ApplicationController
  def index
    @product = Product.find params[:product_id]
    @pagy_reviews, @reviews = pagy(@product.reviews.ordered, page_param: :reviews_page)
  end

  def show
  end

  def new
    @product = Product.find params[:product_id]
    @review = @product.reviews.new
  end

  def create
    @product = Product.find params[:product_id]
    @review = @product.reviews.new(review_params.merge(user: current_user))
    if @review.save
      @pagy_reviews, @reviews = pagy(@product.reviews.ordered, page_param: :reviews_page)
      respond_to do |format|
        format.html { redirect_to [ @product.store, @product ], notice: "Your review has been created!" }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @review = Review.find params[:id]
  end

  def update
    @review = Review.find params[:id]
    if @review.update(review_params)
      respond_to do |format|
        format.html { redirect_to @review.reviewable, notice: "Your review has been updated!" }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find params[:id]
    if @review.destroy
      respond_to do |format|
        format.html { redirect_to @review.reviewable, notice: "Your review has been updated!" }
        format.turbo_stream
      end
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def review_params
     params.expect(review: [ :title, :body ])
  end
end
