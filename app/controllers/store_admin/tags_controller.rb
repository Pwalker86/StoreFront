class StoreAdmin::TagsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @product.tag_list.add(params[:tag])
    render json: { tags: @product.tag_list }, status: :ok
  end

  def destroy
    @product = Product.find(params[:product_id])
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

  def tag_params
     params.expect(product: [ :tag ])
  end
end
