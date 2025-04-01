class CreateOrderExports < ActiveRecord::Migration[8.0]
  def change
    create_table :order_exports do |t|
      t.datetime :date_exported_at
      t.integer :order_count
      t.timestamps
    end
  end
end
