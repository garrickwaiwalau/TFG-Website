# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_01_30_183908) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "air_shipments", force: :cascade do |t|
    t.string "reference_number", null: false
    t.string "tracking_id", null: false
    t.string "hawb_number"
    t.string "mawb_number"
    t.string "po_number"
    t.string "shipper"
    t.string "consignee"
    t.string "flight_number"
    t.integer "pcs"
    t.decimal "gross_weight", precision: 11, scale: 3
    t.decimal "cbm", precision: 11, scale: 3
    t.string "pol"
    t.string "pod"
    t.string "dest"
    t.date "etd"
    t.date "atd"
    t.date "eta"
    t.date "ata"
    t.string "status"
    t.string "pic"
    t.string "agent"
    t.string "division"
    t.string "internal_type_1"
    t.string "internal_type_2"
    t.boolean "file_pass_to_op"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reference_number"], name: "index_air_shipments_on_reference_number", unique: true
  end

  create_table "contacts", force: :cascade do |t|
    t.string "reference_number"
    t.string "first_name"
    t.string "last_name"
    t.string "services", null: false
    t.string "email"
    t.string "phone"
    t.string "subject"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reference_number"], name: "index_contacts_on_reference_number", unique: true
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "ocean_shipments", force: :cascade do |t|
    t.string "shipment_type", null: false
    t.string "tracking_id", null: false
    t.string "reference_number", null: false
    t.string "hbl_number"
    t.string "mbl_number"
    t.string "po_number"
    t.string "shipper"
    t.string "consignee"
    t.string "vessel"
    t.string "voyage"
    t.string "container_number"
    t.string "container_size"
    t.integer "pcs"
    t.decimal "gross_weight", precision: 11, scale: 3
    t.decimal "cbm", precision: 11, scale: 3
    t.string "pol"
    t.string "pod"
    t.string "dest"
    t.date "etd"
    t.date "atd"
    t.date "eta"
    t.date "ata"
    t.date "dest_eta"
    t.date "dest_ata"
    t.string "status"
    t.string "pic"
    t.string "agent"
    t.string "division"
    t.string "internal_type_1"
    t.string "internal_type_2"
    t.boolean "file_pass_to_op"
    t.date "status_send_date"
    t.boolean "pre_alert_completed"
    t.string "pre_alert_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reference_number"], name: "index_ocean_shipments_on_reference_number", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.integer "quantity"
    t.string "packagingType"
    t.decimal "length", precision: 10, scale: 2
    t.decimal "width", precision: 10, scale: 2
    t.decimal "height", precision: 10, scale: 2
    t.decimal "weight", precision: 10, scale: 2
    t.bigint "quote_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quote_id"], name: "index_products_on_quote_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.string "reference_number"
    t.string "mode_of_transport"
    t.string "commodity_air_truck"
    t.string "shipment_type"
    t.decimal "quantity_ocean"
    t.string "container_type"
    t.string "packaging_type"
    t.string "commodity_ocean"
    t.decimal "length_ocean", precision: 10, scale: 2
    t.decimal "width_ocean", precision: 10, scale: 2
    t.decimal "height_ocean", precision: 10, scale: 2
    t.decimal "weight_ocean", precision: 10, scale: 2
    t.string "from_address"
    t.string "to_address"
    t.string "from_city"
    t.string "to_city"
    t.string "from_state_province"
    t.string "to_state_province"
    t.string "from_country"
    t.string "to_country"
    t.string "from_zip_postal"
    t.string "to_zip_postal"
    t.date "cargo_ready_date"
    t.string "sender_title"
    t.string "sender_firstname"
    t.string "sender_lastname"
    t.string "sender_company"
    t.string "sender_address"
    t.string "sender_city"
    t.string "sender_state_province"
    t.string "sender_country"
    t.string "sender_zip_postal"
    t.string "sender_phone"
    t.string "sender_email", null: false
    t.decimal "amount_requested", precision: 10, scale: 2
    t.string "amount_requested_currency", default: "CAD"
    t.string "marketing_use"
    t.boolean "customs_clearance"
    t.boolean "existing_customer"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reference_number"], name: "index_quotes_on_reference_number", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "products", "quotes"
end
