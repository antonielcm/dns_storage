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

ActiveRecord::Schema.define(version: 2020_12_14_004658) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dns_records", force: :cascade do |t|
    t.bigint "ip_address_id", null: false
    t.bigint "domain_name_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["domain_name_id"], name: "index_dns_records_on_domain_name_id"
    t.index ["ip_address_id"], name: "index_dns_records_on_ip_address_id"
  end

  create_table "domain_names", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ip_addresses", force: :cascade do |t|
    t.string "ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "dns_records", "domain_names"
  add_foreign_key "dns_records", "ip_addresses"
end
