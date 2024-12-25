class AddCommodityToQuotes < ActiveRecord::Migration[7.2]
  def change
    add_column :quotes, :commodity, :string
  end
end
