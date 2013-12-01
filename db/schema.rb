# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131130232739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", force: true do |t|
    t.integer  "period_id"
    t.boolean  "took"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "frequencies", force: true do |t|
    t.integer  "pill_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
  end

  add_index "frequencies", ["pill_id"], name: "index_frequencies_on_pill_id", using: :btree

  create_table "inventories", force: true do |t|
    t.integer  "pill_id"
    t.datetime "prescription_date"
    t.integer  "number_of_pills"
    t.integer  "refills"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inventories", ["pill_id"], name: "index_inventories_on_pill_id", using: :btree

  create_table "periods", force: true do |t|
    t.integer  "pill_id"
    t.datetime "time_of_day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "periods", ["pill_id"], name: "index_periods_on_pill_id", using: :btree

  create_table "pill_data", force: true do |t|
    t.string   "name"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pills", force: true do |t|
    t.integer  "user_id"
    t.integer  "pill_data_id"
    t.integer  "dosage_amount"
    t.integer  "unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
  end

  add_index "pills", ["user_id", "pill_data_id"], name: "index_pills_on_user_id_and_pill_data_id", using: :btree

  create_table "units", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "pharmacy"
    t.string   "pharmacy_phone"
    t.integer  "caretaker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["caretaker_id"], name: "index_users_on_caretaker_id", using: :btree

end
