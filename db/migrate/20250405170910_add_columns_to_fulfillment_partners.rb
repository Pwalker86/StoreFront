class AddColumnsToFulfillmentPartners < ActiveRecord::Migration[8.0]
  def change
    remove_column :fulfillment_partners, :file_format, :string
    add_column :fulfillment_partners, :csv_headers, :string, array: true, default: []
    add_column :fulfillment_partners, :type, :string, null: false, default: "CsvPartner"
  end
end
