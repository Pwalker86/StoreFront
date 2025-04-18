class StoreAdmin::ServicesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @service = StaticService.new(store_id: params[:store_id])
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
