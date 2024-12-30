class CreateContacts < ActiveRecord::Migration[7.2]
  def change
    create_table :contacts do |t|
      t.string :reference_number
      t.string :first_name
      t.string :last_name
      t.string :services, null: false
      t.string :email
      t.string :phone
      t.string :subject
      t.text :message

      t.timestamps
    end

    # indexing
    add_index :contacts, :reference_number, unique: true
  end
end
