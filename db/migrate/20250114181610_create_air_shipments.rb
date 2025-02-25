class CreateAirShipments < ActiveRecord::Migration[7.2]
  def change
    create_table :air_shipments do |t|
      t.string :reference_number, null: false
      t.string :tracking_id, null: false
      t.string :hawb_number
      t.string :mawb_number
      t.string :po_number
      t.string :shipper
      t.string :consignee
      t.string :flight_number
      t.integer :pcs, precision: 11, scale: 3
      t.decimal :gross_weight, precision: 11, scale: 3
      t.decimal :cbm, precision: 11, scale: 3
      t.string :pol
      t.string :pod
      t.string :dest
      t.date :etd
      t.date :atd
      t.date :eta
      t.date :ata
      t.string :status
      t.string :pic
      t.string :agent
      t.string :division
      t.string :internal_type_1
      t.string :internal_type_2
      t.boolean :file_pass_to_op

      t.timestamps
    end

    # indexing
    add_index :air_shipments, :reference_number, unique: true
  end
end
