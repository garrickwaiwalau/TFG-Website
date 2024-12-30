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

ActiveRecord::Schema[7.2].define(version: 2024_12_18_220540) do
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

  create_table "products", force: :cascade do |t|
    t.integer "quantity"
    t.string "packagingType"
    t.decimal "length", precision: 10, scale: 2
    t.decimal "width", precision: 10, scale: 2
    t.decimal "height", precision: 10, scale: 2
    t.decimal "weight", precision: 10, scale: 2
    t.integer "quote_id", null: false
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

  add_foreign_key "products", "quotes"
end
