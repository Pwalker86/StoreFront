class StoresController < ApplicationController
  def index
  end

  def show
    begin
      @store = Store.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "Store not found!" and return
    end

    @pagy, @reviews = pagy(@store.reviews.ordered, limt: 5, page_param: :reviews_page)
  end

  def remove_spotlight
    @store = current_store_admin.store
    @store.spotlight.purge_later
    respond_to do |format|
        format.html { redirect_to edit_store_path(@store), notice: "Image removed!" }
        format.turbo_stream
    end
  end
end
