class StoreImagesController < ApplicationController
  def show
    begin
      @store = Store.find(params[:store_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "Store not found!" and return
    end
    @spotlight = Store.find(params[:store_id]).spotlight
  end
end
