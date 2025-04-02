class ShippingDetailsController < ApplicationController
  def new
  end

  def create
    # TODO: update to attache file to model, then use callback to process job, a la FulfillmentPartner
    ImportTrackingNumbersJob.perform_async(params[:file].path)
  end
end
