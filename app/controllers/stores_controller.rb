class StoresController < ApplicationController
  before_action :authenticate_store_admin!, except: [ :show ]

  def index
  end

  def show
    @store = Store.find(params[:id])
    @products = ProductDecorator.decorate_collection(@store.products.where(archived: false))
  end

  def new
    @store = current_store_admin.build_store
  end

  def create
    debugger
    store = current_store_admin.build_store(store_params)
    if store.save
      redirect_to store, notice: "Your store has been created!"
    else
      redirect_to new_store_path, alert: "something went wrong"
    end
  end

  def edit
    @store = current_store_admin.store
  end

  def update
    store = current_store_admin.store
    if store.update(store_params)
      redirect_to store_path(store), notice: "Store has been updated!"
    else
      redirect_to edit_store_path store, alert: "Something went wrong"
    end
  end

  def remove_spotlight
    @store = current_store_admin.store
    if @store.spotlight.purge
      redirect_to store_path(@store), notice: "spotlight has been removed"
    else
      redirect_to @store, alert: "something didn't work"
    end
  end

  def destroy
  end

  private

  def store_params
    params.expect(store: [ :name, :email, :phone_number, :location, :mission_statement, :location, :spotlight ])
  end
end
