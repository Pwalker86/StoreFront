class CreateServiceQuotes < ActiveRecord::Migration[8.0]
  def change
    create_table :service_quotes do |t|
      t.references :services, null: false, foreign_key: true
      t.string :customer_name
      t.string :contact_number
      t.string :contact_email
      t.text :details
      t.text :notes

      t.timestamps
    end
  end
end
