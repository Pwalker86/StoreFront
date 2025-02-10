class StoresController < ApplicationController
  before_action :authenticate_store_admin!, except: [ :show ]

  def index
  end

  def show
    begin
      @store = Store.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "Store not found!" and return
    end

    @pagy_stores, products = pagy(@store.products.where(archived: false).order(:name))
    @products = ProductDecorator.decorate_collection(products)

    @pagy, @reviews = pagy(@store.reviews.ordered)
  end

  def new
    @store = current_store_admin.build_store
  end

  def create
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
    @store = current_store_admin.store
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to edit_store_path(@store), notice: "Store was successfully updated." }
        format.json { render :show, status: :ok, location: store }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_spotlight
    @store = current_store_admin.store
    @store.spotlight.purge_later
    respond_to do |format|
        format.html { redirect_to edit_store_path(@store), notice: "Image removed!" }
        format.turbo_stream
    end
  end

  def destroy
  end

  private

  def store_params
    params.expect(store: [ :name, :email, :phone_number, :location, :mission_statement, :location, :spotlight ])
  end
end
