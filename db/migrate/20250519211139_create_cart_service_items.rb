class CreateCartServiceItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_service_items do |t|
      t.belongs_to :service, null: false, foreign_key: true
      t.belongs_to :cart, null: false, foreign_key: true
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
