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

ActiveRecord::Schema.define(version: 2022_01_08_214926) do

  create_table "inventories", force: :cascade do |t|
    t.string "name"
    t.string "remark"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "inventory_items", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "price"
    t.string "remark"
  end

  create_table "records", force: :cascade do |t|
    t.integer "quantity", default: 0
    t.integer "inventory_id", null: false
    t.integer "inventory_item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inventory_id", "inventory_item_id"], name: "index_records_on_inventory_id_and_inventory_item_id", unique: true
    t.index ["inventory_id"], name: "index_records_on_inventory_id"
    t.index ["inventory_item_id"], name: "index_records_on_inventory_item_id"
  end

  add_foreign_key "records", "inventories"
  add_foreign_key "records", "inventory_items"
end
