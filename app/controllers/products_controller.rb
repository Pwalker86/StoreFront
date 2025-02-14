class ProductsController < ApplicationController
  # GET /products or /products.json
  def index
    @store = Store.find(params[:store_id])
    @pagy_products, products = pagy(@store.products.where(archived: false).order(:name), limit: 6, page_param: :products_page)
    @products = ProductDecorator.decorate_collection(products)
  end

  # GET /products/1 or /products/1.json
  def show
    @store = Store.find params[:store_id]
    @product = @store.products.find (params[:id])
    @pagy, @reviews = pagy(@product.reviews.ordered)
  end
end
