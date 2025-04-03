class ShippingDetailsController < ApplicationController
  def new
    @shipping_detail = ShippingDetail.new
  end

  def create
    import = ShippingDetailsImport.new(shipping_detail_params.merge(store_admin: current_store_admin))
    if import.save
      ImportTrackingNumbersJob.perform_async(import.id)
      redirect_to store_admin_store_orders_path(current_store_admin, current_store_admin.store), notice: "Shipping details are being imported."
    else
      flash.now[:alert] = "There was an error importing the shipping details."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def shipping_detail_params
    params.expect(shipping_detail: [ :import_file ])
  end
end
