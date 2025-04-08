class StoreAdmin::FulfillmentPartnersController < ApplicationController
  def show
    @fulfillment_partner = FulfillmentPartner.find_by(store_id: params[:store_id])
  end

  def new
    # initialize as a CsvPartner by default, because STI models can't be instantiated directly.
    @fulfillment_partner = CsvPartner.new(store_id: params[:store_id])
    @csv_header_options = CsvPartner::CSV_HEADER_OPTIONS
  end

  def create
    begin
      store = Store.find(params[:store_id])
      @fulfillment_partner = FulfillmentPartnerFactory.create_fulfillment_partner(fulfillment_partner_params[:type], fulfillment_partner_params.merge(store_id: params[:store_id]))
      if @fulfillment_partner.save!
        redirect_to store_admin_store_fulfillment_partner_path(current_store_admin, store, @fulfillment_partner), notice: "Fulfillment partner created!"
      else
        render :new, status: :unprocessable_entity
      end
    rescue FulfillmentPartnerFactory::UnknownFulfillmentPartnerTypeError, FulfillmentPartnerFactory::NilHeadersError => e
      Rails.logger.error("Error creating fulfillment partner: #{e.message}")
      redirect_to new_store_admin_store_fulfillment_partner_path(current_store_admin, store), alert: "An error occurred while creating the fulfillment partner. Please try again."
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error("Store not found: #{e.message}")
      redirect_to store_admin_stores_path(current_store_admin), alert: "Store not found."
    rescue StandardError => e
      Rails.logger.error("Unexpected error: #{e.message}")
      redirect_to new_store_admin_store_fulfillment_partner_path(current_store_admin, store), alert: "An unexpected error occurred. Please try again."
    end
  end

  def edit
    @fulfillment_partner = FulfillmentPartner.find_by(store_id: params[:store_id])
  end

  def update
    begin
      store = Store.find(params[:store_id])
      @fulfillment_partner = store.fulfillment_partner
      @fulfillment_partner = FulfillmentPartnerFactory.update_fulfillment_partner(@fulfillment_partner, fulfillment_partner_params[:type], fulfillment_partner_params)
      if @fulfillment_partner.save
        redirect_to store_admin_store_fulfillment_partner_path(current_store_admin, store, @fulfillment_partner), notice: "Fulfillment partner updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    rescue FulfillmentPartnerFactory::UnknownFulfillmentPartnerTypeError, FulfillmentPartnerFactory::NilHeadersError => e
      Rails.logger.error("Error updating fulfillment partner: #{e.message}")
      redirect_to new_store_admin_store_fulfillment_partner_path(current_store_admin, store), alert: "Fulfillment partner update failed!"
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error("Store not found: #{e.message}")
      redirect_to store_admin_stores_path(current_store_admin), alert: "Store not found."
    rescue StandardError => e
      Rails.logger.error("Unexpected error: #{e.message}")
      render :new, status: :internal_server_error, alert: "An unexpected error occurred. Please try again."
    end
  end

  def destroy
    store = Store.find(params[:store_id])
    @fulfillment_partner = store.fulfillment_partner
    @fulfillment_partner.destroy
    redirect_to new_store_admin_store_fulfillment_partner_path(current_store_admin, store), notice: "Fulfillment partner deleted!"
  end

  private

  def fulfillment_partner_params
    params.expect(fulfillment_partner: [ :name, :email, :phone, :location, :type, :file_schema, :file_schema_json, csv_headers: CsvPartner::CSV_HEADER_OPTIONS.map(&:to_sym) ])
  end
end
