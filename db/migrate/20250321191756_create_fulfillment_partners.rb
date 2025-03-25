class CreateFulfillmentPartners < ActiveRecord::Migration[8.0]
  def change
    create_table :fulfillment_partners do |t|
      t.references :store, null: true, foreign_key: true
      t.string :name, null: false
      t.string :location
      t.string :phone
      t.string :email
      t.string :file_format, null: false
      t.jsonb :file_structure, null: false

      t.timestamps
    end
  end
end
