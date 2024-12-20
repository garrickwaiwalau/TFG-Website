class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      # Package / Cargo Information
      t.string :mode_of_transport
      t.string :container_size
      t.decimal :quantity_by_sea

      # Shipping Information
      t.string :from_address
      t.string :to_address
      t.string :from_city
      t.string :to_city
      t.string :from_state_province
      t.string :to_state_province
      t.string :from_country
      t.string :to_country
      t.string :from_zip_postal
      t.string :to_zip_postal
      t.date :from_cargo_available
      t.date :to_cargo_required

      # Contact Information
      t.string :sender_title
      t.string :sender_firstname
      t.string :sender_lastname
      t.string :sender_company
      t.string :sender_address
      t.string :sender_city
      t.string :sender_state_province
      t.string :sender_country
      t.string :sender_zip_postal
      t.string :sender_phone
      t.string :sender_email

      # Others
      t.decimal :amount_requested, precision: 10, scale: 2  # todo confirm decimal place
      t.string :marketing_use
      t.boolean :customs_clearance
      t.boolean :existing_customer

      # Add references for products (nested attributes)
      t.timestamps
    end

    # Add an index for efficient queries (optional but recommended)
    add_index :quotes, :sender_email # todo maybe needed
  end
end
