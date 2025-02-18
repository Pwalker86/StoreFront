class StoreAdmin::StoreImagesController < ApplicationController
  before_action :authenticate_store_admin!
  before_action :set_store
  before_action { authorize @store, policy_class: Admin::StoreImagePolicy }

  def show
    set_store
    @spotlight = Store.find(params[:store_id]).spotlight
  end

  def new
    set_store
  end

  def create
  end

  def edit
    set_store
  end

  def update
    set_store
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to edit_store_admin_store_path(@store.store_admin, @store), notice: "Store was successfully updated." }
        format.json { render :show, status: :ok, location: store }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    set_store
    @store.spotlight.purge_later
    respond_to do |format|
        format.html { redirect_to edit_store_admin_store_path(@store.store_admin, @store), notice: "Image has been queued for deletion!" }
        format.turbo_stream
    end
  end

  private

  def pundit_user
    current_store_admin
  end

  def set_store
    begin
      @store = Store.find(params[:store_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "Store not found!" and return
    end
  end

  def store_params
    params.expect(store: [ :spotlight ])
  end
end
