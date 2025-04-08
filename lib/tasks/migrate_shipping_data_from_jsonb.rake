namespace :orders do
  desc "migrate shipping data from JSONB to new columns"
  task migrate_shipping_data_from_json: :environment do
    Order.reset_column_information
    Order.find_each do |order|
      # Assuming the old shipping_address JSONB column has not been removed yet
      # and the new columns are already created in the database.
      begin
        if order.shipping_address
          order.update!(
            address1: order.shipping_address["address1"],
            address2: order.shipping_address["address2"],
            city: order.shipping_address["city"],
            state: order.shipping_address["state"],
            postal_code: order.shipping_address["postal_code"]
          )
        end
      rescue StandardError => e
        puts "Error updating order #{order.id}: #{e.message}"
      end
    end
  end
end
