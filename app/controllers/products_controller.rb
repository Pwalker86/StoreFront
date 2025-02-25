class ProductsController < ApplicationController
  def index
    @store = Store.find(params[:store_id])
    @pagy_products, products = pagy(@store.products.where(archived: false).order(:name), limit: 6, page_param: :products_page)
    @products = ProductDecorator.decorate_collection(products)
  end

  def show
    begin
      @store = Store.find params[:store_id]
      @product = @store.products.find (params[:id])
      @pagy, @reviews = pagy(@product.reviews.ordered)
    rescue ActiveRecord::RecordNotFound
      render "products/not_found", status: :not_found
    end
  end
end
