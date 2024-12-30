class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.string :reference_number

      # Package / Cargo Information
      t.string :mode_of_transport

      # Air/ Trucking Shipment Details
      t.string :commodity_air_truck

      # Ocean Shipment Details
      t.string :shipment_type
      t.decimal :quantity_ocean
      t.string :container_type
      t.string :packaging_type
      t.string :commodity_ocean
      t.decimal :length_ocean, precision: 10, scale: 2
      t.decimal :width_ocean, precision: 10, scale: 2
      t.decimal :height_ocean, precision: 10, scale: 2
      t.decimal :weight_ocean, precision: 10, scale: 2

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
      t.date :cargo_ready_date

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
      t.string :sender_email, null: false

      # Others
      t.decimal :amount_requested, precision: 10, scale: 2
      t.string :amount_requested_currency, default: "CAD"
      t.string :marketing_use
      t.boolean :customs_clearance
      t.boolean :existing_customer
      t.text :comment

      # Add references for products (nested attributes)
      t.timestamps
    end

    # indexing
    add_index :quotes, :reference_number, unique: true
  end
end
