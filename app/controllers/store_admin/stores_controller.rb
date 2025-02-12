class StoreAdmin::StoresController < ApplicationController
  before_action :authenticate_store_admin!
  before_action :find_store
  before_action :verify_store_admin, except: [ :show ]

  def show
    begin
      @store = Store.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "Store not found!" and return
    end

    @pagy, @reviews = pagy(@store.reviews.ordered, limt: 5, page_param: :reviews_page)
  end

  def edit
  end

  private

  def find_store
    @store = Store.find(params[:id])
  end

  def verify_store_admin
    if current_store_admin != @store.store_admin
      flash[:alert] = "You are not authorized to access this store."
      Rails.logger.warn "Unauthorized access attempt to store ##{params[:id]} by store admin ##{current_store_admin.id}"
      redirect_to root_path and return
    end
  end
end
