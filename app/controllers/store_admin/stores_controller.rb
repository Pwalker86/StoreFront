class StoreAdmin::StoresController < ApplicationController
  before_action :set_store, except: [ :new, :create ]
  before_action { authorize @store, policy_class: Admin::StorePolicy }

  def show
  end

  def edit
  end

  def new
    @store = current_store_admin.build_store
  end

  def create
    store = current_store_admin.build_store(store_params)
    if store.save
      redirect_to store_admin_store_path(current_store_admin, store), notice: "Your store has been created!"
    else
      redirect_to new_store_admin_store_path(current_store_admin), alert: "something went wrong"
    end
  end

  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to store_admin_store_path(@store.store_admin, @store), notice: "Store was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def pundit_user
    current_store_admin
  end

   def user_not_authorized
     flash[:alert] = "You are not authorized to perform this action."
     redirect_back_or_to(root_path)
   end

  def set_store
    begin
      @store = Store.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "Store not found!" and return
    end
  end

  def store_params
    params.expect(store: [ :name, :email, :phone_number, :location, :mission_statement, :location ])
  end
end
