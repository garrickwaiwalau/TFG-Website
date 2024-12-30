class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.integer :quantity
      t.string :packagingType
      t.decimal :length, precision: 10, scale: 2
      t.decimal :width, precision: 10, scale: 2
      t.decimal :height, precision: 10, scale: 2
      t.decimal :weight, precision: 10, scale: 2
      t.references :quote, null: false, foreign_key: true

      t.timestamps
    end
  end
end
