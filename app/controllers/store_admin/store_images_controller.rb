class StoreAdmin::StoreImagesController < ApplicationController
  before_action :authenticate_store_admin!
  before_action :set_store
  before_action { authorize @store, policy_class: Admin::StoreImagePolicy }

  def show
    @spotlight = Store.find(params[:store_id]).spotlight
  end

  def new
  end

  def create
    respond_to do |format|
      begin
        @store.spotlight.attach(store_params[:spotlight])
        msg = "Image was sucessfully uploaded!"
      rescue ActiveSupport::MessageVerifier::InvalidSignature
        msg = "Something went wrong"
      ensure
        format.html { redirect_to edit_store_admin_store_path(@store.store_admin, @store), notice: msg }
      end
    end
  end

  def edit
  end

  def destroy
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
