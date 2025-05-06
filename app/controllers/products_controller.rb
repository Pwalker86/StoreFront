class ProductsController < ApplicationController
  def index
    @store = Store.find(params[:store_id])
    products = @store.cached_store_products
    @pagy_products, @products = pagy(products, limit: 8, page_param: :products_page)
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
