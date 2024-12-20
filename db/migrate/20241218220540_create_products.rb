class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.integer :product_quantity
      t.string :type_of_goods
      t.decimal :length, precision: 10, scale: 2 # todo confirm decimal place
      t.decimal :width, precision: 10, scale: 2
      t.decimal :height, precision: 10, scale: 2
      t.decimal :weight, precision: 10, scale: 2
      t.references :quote, null: false, foreign_key: true

      t.timestamps
    end
  end
end
