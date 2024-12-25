class AddOceanColumnsToQuotes < ActiveRecord::Migration[7.2]
  def change
    add_column :quotes, :container_type, :string
    add_column :quotes, :packaging_type, :string
  end
end
