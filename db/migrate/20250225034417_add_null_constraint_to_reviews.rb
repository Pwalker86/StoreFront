class AddNullConstraintToReviews < ActiveRecord::Migration[8.0]
  def change
    change_column_null :reviews, :user_id, false
  end
end
