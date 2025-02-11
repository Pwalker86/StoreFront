class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :body
      t.float :rating

      t.timestamps
    end
  end
end
