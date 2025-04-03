class CreateShippingDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :shipping_details do |t|
      t.string :tracking_number
      t.string :carrier
      t.datetime :shipped_at
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
