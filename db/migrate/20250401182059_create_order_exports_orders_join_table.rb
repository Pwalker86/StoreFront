class CreateOrderExportsOrdersJoinTable < ActiveRecord::Migration[8.0]
  def change
    create_join_table :orders, :order_exports do |t|
      t.index :order_id
      t.index :order_export_id
    end
  end
end
