class StoreAdmin::FulfillmentPartnersController < ApplicationController
  def show
    store = Store.find(params[:store_id])
    @fulfillment_partner = store.fulfillment_partner
  end

  def new
    store = Store.find(params[:store_id])
    @fulfillment_partner = CsvPartner.new(store: store)
    @csv_header_options = CsvPartner::CSV_HEADER_OPTIONS
  end

  def create
    store = Store.find(params[:store_id])
    @fulfillment_partner = FulfillmentPartnerFactory.create_fulfillment_partner(fulfillment_partner_params[:type], fulfillment_partner_params.merge(store_id: store.id))
    if @fulfillment_partner.save
      redirect_to store_admin_store_fulfillment_partner_path(current_store_admin, store, @fulfillment_partner), notice: "Fulfillment partner created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    store = Store.find(params[:store_id])
    @fulfillment_partner = store.fulfillment_partner
  end

  def update
    store = Store.find(params[:store_id])
    @fulfillment_partner = store.fulfillment_partner
    if @fulfillment_partner.update(fulfillment_partner_params)
      redirect_to store_admin_store_fulfillment_partner_path(current_store_admin, store, @fulfillment_partner), notice: "Fulfillment partner updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    store = Store.find(params[:store_id])
    @fulfillment_partner = store.fulfillment_partner
    @fulfillment_partner.destroy
    redirect_to store_fulfillment_partner_path(store), notice: "Fulfillment partner deleted!"
  end

  private

  def fulfillment_partner_params
    params.expect(fulfillment_partner: [ :name, :email, :phone, :location, :type, :file_schema, :file_schema_json, csv_headers: CsvPartner::CSV_HEADER_OPTIONS.map(&:to_sym) ])
  end
end
