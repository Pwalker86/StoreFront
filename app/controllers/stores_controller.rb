class StoresController < ApplicationController
  before_action :set_store
  before_action { authorize @store, policy_class: StorePolicy }

  def show
    @pagy, @reviews = pagy(@store.reviews.ordered, limt: 5, page_param: :reviews_page)
  end

  private

  def set_store
    begin
      @store = Store.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "Store not found!" and return
    end
  end
end
