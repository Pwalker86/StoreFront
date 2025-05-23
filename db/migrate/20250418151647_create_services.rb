class CreateServices < ActiveRecord::Migration[8.0]
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.text :description
      t.float :duration_in_hours
      t.boolean :is_quote_needed, default: false
      t.float :rate_per_hour
      t.references :store, null: false, foreign_key: true
      t.string :type, null: false # STI column

      t.timestamps
    end
  end
end
