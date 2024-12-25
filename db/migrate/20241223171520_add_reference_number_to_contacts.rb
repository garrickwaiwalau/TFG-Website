class AddReferenceNumberToContacts < ActiveRecord::Migration[7.2]
  def change
    add_column :contacts, :reference_number, :string
    add_index :contacts, :reference_number, unique: true
  end
end
