class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.belongs_to :cart, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 0
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
