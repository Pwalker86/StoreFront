class CreateShippingDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :shipping_details do |t|
      t.string :tracking_number
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
