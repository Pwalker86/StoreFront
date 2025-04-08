namespace :orders do
  desc "migrate shipping data from columns back to JSONB"
  task migrate_shipping_data_to_json: :environment do
    Order.reset_column_information
    Order.find_each do |order|
      begin
        # Assuming the new columns are already created in the database.
        # We will migrate the data back to the old shipping_address JSONB column.
        # This is just an example; adjust the logic as needed.
        # You might want to check if the old column exists before doing this.
        shipping_address = {
          "address1" => order.address1,
          "address2" => order.address2,
          "city" => order.city,
          "state" => order.state,
          "postal_code" => order.postal_code
        }
        order.update!(
          shipping_address: shipping_address
        )
      rescue StandardError => e
        puts "Error updating order #{order.id}: #{e.message}"
      end
    end
  end
end
