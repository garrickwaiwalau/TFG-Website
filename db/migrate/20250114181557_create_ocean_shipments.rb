class CreateOceanShipments < ActiveRecord::Migration[7.2]
  def change
    create_table :ocean_shipments do |t|
      t.string :shipment_type, null: false
      t.string :tracking_id, null: false
      t.string :reference_number, null: false
      t.string :hbl_number
      t.string :mbl_number
      t.string :po_number
      t.string :shipper
      t.string :consignee
      t.string :vessel
      t.string :voyage
      t.string :container_number
      t.string :container_size
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
      t.date :dest_eta
      t.date :dest_ata
      t.string :status
      t.string :pic
      t.string :agent
      t.string :division
      t.string :internal_type_1
      t.string :internal_type_2
      t.boolean :file_pass_to_op
      t.date :status_send_date
      t.boolean :pre_alert_completed
      t.string :pre_alert_email

      t.timestamps
    end

    # indexing
    add_index :ocean_shipments, :reference_number, unique: true
  end
end
