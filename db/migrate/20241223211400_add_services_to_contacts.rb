class AddServicesToContacts < ActiveRecord::Migration[7.2]
  def change
    add_column :contacts, :services, :string, null: false
  end
end
