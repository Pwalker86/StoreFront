class CreateShippingDetailsImports < ActiveRecord::Migration[8.0]
  def change
    create_table :shipping_details_imports do |t|
      t.references :store_admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
