class AddDimensionsWeightToQuotes < ActiveRecord::Migration[7.2]
  def change
    add_column :quotes, :length_ocean, :decimal, precision: 10, scale: 2
    add_column :quotes, :width_ocean, :decimal, precision: 10, scale: 2
    add_column :quotes, :height_ocean, :decimal, precision: 10, scale: 2
    add_column :quotes, :weight_ocean, :decimal, precision: 10, scale: 2
  end
end
