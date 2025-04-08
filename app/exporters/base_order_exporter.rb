# frozen_string_literal: true

class BaseOrderExporter
  def initialize(export, fulfillment_partner)
    @export = export
    @fulfillment_partner = fulfillment_partner
    @orders = export.orders
  end

  def generate
    raise NotImplementedError, "Subclasses must implement the generate method"
  end

  attr_reader :export, :fulfillment_partner, :orders
end
