class ServicesController < ApplicationController
  def index
    store = Store.find(params[:store_id])
    @services = store.services
  end

  def show
  end
end
