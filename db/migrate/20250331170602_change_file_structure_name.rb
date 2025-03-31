class ChangeFileStructureName < ActiveRecord::Migration[8.0]
  def change
    reversible do | direction |
      direction.up do
        rename_column :fulfillment_partners, :file_structure, :file_schema
        change_column_null :fulfillment_partners, :file_schema, true
      end

      direction.down do
        rename_column :fulfillment_partners, :file_schema, :file_structure
        change_column_null :fulfillment_partners, :file_structure, false
      end
    end
  end
end
