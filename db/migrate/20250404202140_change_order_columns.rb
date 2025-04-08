class ChangeOrderColumns < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :full_name, :string
    add_column :orders, :address1, :string
    add_column :orders, :address2, :string
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :postal_code, :string
    add_column :orders, :instructions, :text

    reversible do |dir|
      dir.up do
        # Migrate the data from the old shipping_address column to the new address columns
        Rake::Task['orders:migrate_shipping_data_from_json'].invoke
      end

      dir.down do
        Rake::Task['orders:migrate_shipping_data_to_json'].invoke
      end
    end

    remove_column :orders, :shipping_address, :jsonb, default: {}
  end
end
