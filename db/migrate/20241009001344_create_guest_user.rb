class CreateGuestUser < ActiveRecord::Migration[7.1]
  def change
    create_table :guests do |t|
      t.string :email
      t.timestamps
    end
  end
end
