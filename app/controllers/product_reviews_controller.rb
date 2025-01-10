class ProductReviewsController < ApplicationController
  def index
    @product = Product.find params[:product_id]
    @reviews = @product.reviews.ordered
  end

  def show
  end

  def new
    @product = Product.find params[:product_id]
  end

  def create
    @product = Product.find params[:product_id]
    @review = @product.reviews.new(review_params)
    if @review.save
      respond_to do |format|
        format.html { redirect_to [ @product.store, @product ], notice: "Your review has been created!" }
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
