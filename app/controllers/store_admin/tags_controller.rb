class StoreAdmin::TagsController < ApplicationController
  before_action :authenticate_store_admin!
  before_action :set_product
  before_action { authorize @product, policy_class: Admin::TagPolicy }

  def new
  end

  def create
    @product.tag_list.add(tag_params[:tag])
    @tag = tag_params[:tag]
    if @product.save
      respond_to do |format|
        format.json { render json: { tags: @product.tag_list }, status: :ok }
        format.turbo_stream
      end
    else
      render json: { error: "Unable to add tag" }, status: :unprocessable_entity
    end
  end

  def destroy
    @product.tag_list.remove(tag_params[:tag])
    @tag = tag_params[:tag]
    if @product.save
      respond_to do |format|
        format.html { redirect_to @review.reviewable, notice: "Your review has been updated!" }
        format.turbo_stream
      end
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def pundit_user
    current_store_admin
  end

  def tag_params
     params.expect(product: [ :tag ])
  end
end
