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

ActiveRecord::Schema[7.2].define(version: 2024_12_20_162622) do
  create_table "contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "subject"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "product_name"
    t.integer "product_quantity"
    t.string "type_of_goods"
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
    t.string "mode_of_transport"
    t.string "container_size"
    t.decimal "quantity_by_sea"
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
    t.date "from_cargo_available"
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
    t.string "marketing_use"
    t.boolean "customs_clearance"
    t.boolean "existing_customer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "amount_requested_currency", default: "CAD"
    t.text "message"
    t.index ["sender_email"], name: "index_quotes_on_sender_email"
  end

  add_foreign_key "products", "quotes"
end
