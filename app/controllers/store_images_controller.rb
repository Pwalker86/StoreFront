class StoreImagesController < ApplicationController
  def show
    @spotlight = Store.find(params[:store_id]).spotlight
  end
end
