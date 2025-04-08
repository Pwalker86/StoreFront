# frozen_string_literal: true

class JsonOrderExporter < BaseOrderExporter
  def generate
    order_data = orders.map do |order|
      transform_order_to_json(order)
    end
    JSON.pretty_generate(order_data)
  end

  private

  def transform_order_to_json(order)
    data = {
      id: order.id,
      email: order.email,
      created_at: order.created_at,
      status: order.status
    }

    # Add order items if available
    if order.respond_to?(:order_items) && order.order_items.present?
      data[:items] = order.order_items.map do |item|
        {
          product_id: item.product_id,
          product_name: item.product.name,
          quantity: item.quantity,
          price: item.price
        }
      end
    end

    # Add shipping details if available
    if order.respond_to?(:shipping_details) && order.shipping_details.present?
      data[:shipping] = order.shipping_details.map do |shipping|
        {
          carrier: shipping.carrier,
          tracking_number: shipping.tracking_number,
          shipped_at: shipping.shipped_at
        }
      end
    end

    # Apply any schema transformations from the fulfillment partner
    apply_schema_transformations(data)
  end

  def apply_schema_transformations(data)
    # If the partner has a specific schema defined, we can transform the data
    # to match that schema. For now, we just return the data as is.
    # This could be enhanced in the future to use the partner's file_schema
    # to transform the data structure.
    return data unless fulfillment_partner.file_schema.present?

    # Example of potential future implementation:
    # SchemaMapper.map(data, fulfillment_partner.file_schema)
    data
  end
end
