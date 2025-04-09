class SearchController < ApplicationController
  def index
    @products = Product.search_by(params[:query]).joins(:store).select('products.id', 'products.store_id', 'products.name', 'stores.name as store_name').to_a.map do |item|
      { href: "/stores/#{item.store_id}/products/#{item.id}", name: item.name, store_name: item.store_name }
    end
    respond_to do |format|
      format.html { }
      format.json { render json: @products }
    end
  end
end
