class RemoveNotNullConstraint < ActiveRecord::Migration[8.0]
  def up
    change_column_null :products, :description, true
  end

  def down
    change_column_null :products, :description, false
  end
end
