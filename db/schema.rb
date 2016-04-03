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

ActiveRecord::Schema.define(version: 20160403232512) do

  create_table "actualization_logs", force: :cascade do |t|
    t.string   "status",      limit: 255
    t.integer  "items_count", limit: 4
    t.text     "error",       limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "log_type",    limit: 255
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id",        limit: 4
    t.integer  "quantity",       limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "stored_item_id", limit: 4
  end

  add_index "cart_items", ["cart_id"], name: "index_cart_items_on_cart_id", using: :btree

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.decimal  "price_sum",            precision: 10, scale: 2, default: 0.0
  end

  add_index "carts", ["user_id"], name: "index_carts_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "parent_id",   limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "items_count", limit: 4,   default: 0
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
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "category_id", limit: 4
    t.string   "barcode",     limit: 13
    t.boolean  "active",      limit: 1,     default: true
  end

  add_index "items", ["category_id"], name: "index_items_on_category_id", using: :btree

  create_table "magazines", force: :cascade do |t|
    t.string   "number",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "offers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id",       limit: 4
    t.integer  "quantity",       limit: 4
    t.decimal  "price",                    precision: 10, scale: 2
    t.decimal  "total_price",              precision: 10, scale: 2
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "stored_item_id", limit: 4
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.decimal  "price",                precision: 10, scale: 2
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "stored_items", force: :cascade do |t|
    t.integer  "magazine_id", limit: 4
    t.integer  "item_id",     limit: 4
    t.integer  "quantity",    limit: 4
    t.decimal  "price",                   precision: 10, scale: 2
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "type",        limit: 255
    t.integer  "offer_id",    limit: 4
  end

  add_index "stored_items", ["item_id"], name: "index_stored_items_on_item_id", using: :btree
  add_index "stored_items", ["magazine_id"], name: "index_stored_items_on_magazine_id", using: :btree
  add_index "stored_items", ["offer_id"], name: "index_stored_items_on_offer_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "contractor_sym",  limit: 255
    t.string   "reciver_sym",     limit: 255
    t.string   "email",           limit: 255
    t.string   "login",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "admin",           limit: 1,   default: false
  end

  add_index "users", ["login"], name: "index_users_on_login", using: :btree

  add_foreign_key "cart_items", "carts"
  add_foreign_key "carts", "users"
  add_foreign_key "items", "categories"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "stored_items", "items"
  add_foreign_key "stored_items", "magazines"
  add_foreign_key "stored_items", "offers"
end
