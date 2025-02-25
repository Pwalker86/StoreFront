class StoreReviewsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_review, only: [ :show, :edit, :update, :destroy ]
  before_action { authorize @review, policy_class: StoreReviewPolicy }

  def index
    @store = Store.find params[:store_id]
    @pagy_reviews, @reviews = pagy(@store.reviews.order(created_at: :desc), limt: 6, page_param: :reviews_page)
  end

  def show
  end

  def new
    @store = Store.find params[:store_id]
    @review = @store.reviews.new
  end

  def create
    @store = Store.find params[:store_id]
    @review = @store.reviews.new(review_params.merge(user: current_user))
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
  end

  def update
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

  def set_review
    @review = Review.find params[:id]
  end
end
