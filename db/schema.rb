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

ActiveRecord::Schema.define(version: 2021_02_28_211912) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "addressable_type", null: false
    t.bigint "addressable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "company_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "dhcp_servers", force: :cascade do |t|
    t.string "name"
    t.string "server_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ips", force: :cascade do |t|
    t.string "address"
    t.bigint "pool_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pool_id"], name: "index_ips_on_pool_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_locations_on_customer_id"
  end

  create_table "pools", force: :cascade do |t|
    t.string "name"
    t.string "start_ip"
    t.string "end_ip"
    t.bigint "subnet_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subnet_id"], name: "index_pools_on_subnet_id"
  end

  create_table "ports", force: :cascade do |t|
    t.integer "port_number"
    t.string "name"
    t.text "description"
    t.string "portable_type", null: false
    t.bigint "portable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["portable_type", "portable_id"], name: "index_ports_on_portable"
  end

  create_table "shared_networks", force: :cascade do |t|
    t.string "name"
    t.string "relayed_from_ip"
    t.bigint "dhcp_server_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dhcp_server_id"], name: "index_shared_networks_on_dhcp_server_id"
  end

  create_table "slots", force: :cascade do |t|
    t.integer "slot_number"
    t.string "name"
    t.text "description"
    t.bigint "switch_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["switch_id"], name: "index_slots_on_switch_id"
  end

  create_table "subnets", force: :cascade do |t|
    t.string "name"
    t.string "network_address"
    t.integer "cidr"
    t.bigint "shared_network_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shared_network_id"], name: "index_subnets_on_shared_network_id"
  end

  create_table "switches", force: :cascade do |t|
    t.string "name"
    t.string "manufacturer"
    t.string "model"
    t.string "management_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "ips", "pools"
  add_foreign_key "locations", "customers"
  add_foreign_key "pools", "subnets"
  add_foreign_key "shared_networks", "dhcp_servers"
  add_foreign_key "slots", "switches"
  add_foreign_key "subnets", "shared_networks"
end
