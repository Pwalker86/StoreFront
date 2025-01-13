class ProductSearchController < ApplicationController
  def home_search
    products = Product.search_by(params[:query]).select(:id, :store_id, :name).map do |item|
      { href: "/stores/#{item.store_id}/products/#{item.id}", name: item.name }
    end
    respond_to do |format|
      format.json { render json: products }
    end
  end
end
