class StoreAdmin::ServicesController < ApplicationController
  before_action :authenticate_store_admin!
  before_action :check_type, only: [ :create, :update ]

  def index
    @services = current_store_admin.store.services
  end

  def show
    @service = current_store_admin.store.services.find(params[:id])
    authorize @service, policy_class: Admin::ServicePolicy
  end

  def new
    @service = StaticService.new(store_id: params[:store_id])
    authorize @service, policy_class: Admin::ServicePolicy
  end

  def create
    store = Store.find_by(id: params[:store_id])
    unless store
      Rails.logger.error("Store not found for store_id: #{params[:store_id]}")
      redirect_to store_admin_stores_path(current_store_admin), alert: "Store not found." and return
    end
    authorize store, policy_class: Admin::ServicePolicy

    begin
      @service = ServicesFactory.create_service(services_params[:type], services_params.merge(store_id: params[:store_id]))
      if @service.save
        redirect_to store_admin_store_service_path(current_store_admin, store, @service), notice: "Service created!"
      else
        render :new, status: :unprocessable_entity
      end
    rescue ServicesFactory::UnknownServiceTypeError => e
      Rails.logger.error("Error creating service: #{e.message}, params: #{params.inspect}")
      redirect_to new_store_admin_store_service_path(current_store_admin, store), alert: "An error occurred while creating the service. Please try again."
    rescue StandardError => e
      Rails.logger.error("Unexpected error: #{e.message}, params: #{params.inspect}")
      redirect_to new_store_admin_store_service_path(current_store_admin, store), alert: "An unexpected error occurred. Please try again."
    end
  end

  def edit
    @service = current_store_admin.store.services.find(params[:id])
    authorize @service, policy_class: Admin::ServicePolicy
  end

  def update
    store = Store.find_by(id: params[:store_id])
    unless store
      Rails.logger.error("Store not found for store_id: #{params[:store_id]}")
      redirect_to store_admin_stores_path(current_store_admin), alert: "Store not found." and return
    end

    begin
      @service = store.services.find(params[:id])
      authorize @service, policy_class: Admin::ServicePolicy

      @service = ServicesFactory.update_service(@service, services_params[:type], services_params.merge(store_id: params[:store_id]))
      if @service.save
        redirect_to store_admin_store_service_path(current_store_admin, store, @service), notice: "Service updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    rescue ServicesFactory::UnknownServiceTypeError => e
      Rails.logger.error("Error creating service: #{e.message}, params: #{params.inspect}")
      redirect_to edit_store_admin_store_service_path(current_store_admin, store, @service), alert: "An error occurred while updating the service. Please try again."
    rescue StandardError => e
      Rails.logger.error("Unexpected error: #{e.message}, params: #{params.inspect}")
      redirect_to edit_store_admin_store_service_path(current_store_admin, store, @service), alert: "An unexpected error occurred. Please try again."
    end
  end

  def destroy
    @service = current_store_admin.store.services.find(params[:id])
    authorize @service, policy_class: Admin::ServicePolicy
    if @service.destroy
      redirect_to store_admin_store_services_path(current_store_admin, current_store_admin.store), notice: "Service deleted!"
    else
      redirect_to store_admin_store_service_path(current_store_admin, current_store_admin.store, @service), alert: "Failed to delete service."
    end
  end

  private

  def services_params
    params.expect(service: [ :name, :description, :duration_in_hours, :rate_per_hour, :type, :is_quote_needed ])
  end

  def check_type
    unless services_params[:type].in?([ "StaticService", "DynamicService" ])
      Rails.logger.error("Invalid service type: #{services_params[:type]}, params: #{params.inspect}")
        redirect_to store_admin_stores_path(current_store_admin), alert: "Invalid service type." and return
    end
  end

  def pundit_user
    current_store_admin
  end
end
