class AddReferenceNumberToQuotes < ActiveRecord::Migration[7.2]
  def change
    add_column :quotes, :reference_number, :string
    add_index :quotes, :reference_number, unique: true
  end
end
