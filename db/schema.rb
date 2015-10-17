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

ActiveRecord::Schema.define(version: 20150818203234) do

  create_table "actualization_logs", force: :cascade do |t|
    t.string   "status",      limit: 255
    t.integer  "items_count", limit: 4
    t.text     "error",       limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "number",      limit: 255
    t.string   "name",        limit: 255
    t.integer  "small_wrap",  limit: 4
    t.integer  "big_wrap",    limit: 4
    t.text     "photo",       limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "category_id", limit: 4
  end

  add_index "items", ["category_id"], name: "index_items_on_category_id", using: :btree

  create_table "magazines", force: :cascade do |t|
    t.string   "number",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "stored_items", force: :cascade do |t|
    t.integer  "magazine_id", limit: 4
    t.integer  "item_id",     limit: 4
    t.integer  "quantity",    limit: 4
    t.decimal  "price",                 precision: 10, scale: 2
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "stored_items", ["item_id"], name: "index_stored_items_on_item_id", using: :btree
  add_index "stored_items", ["magazine_id"], name: "index_stored_items_on_magazine_id", using: :btree

  add_foreign_key "items", "categories"
  add_foreign_key "stored_items", "items"
  add_foreign_key "stored_items", "magazines"
end
