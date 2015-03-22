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

ActiveRecord::Schema.define(version: 20150322070754) do

  create_table "entries", force: :cascade do |t|
    t.string   "password",    limit: 255
    t.string   "description", limit: 255
    t.string   "username",    limit: 255
    t.boolean  "is_active",   limit: 1,   default: true
    t.integer  "user_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "temp_passwords", force: :cascade do |t|
    t.string   "uuid",        limit: 255
    t.string   "hashed_uuid", limit: 255
    t.string   "email",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",      limit: 100
    t.string   "password",   limit: 255
    t.string   "salt",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token",      limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["token"], name: "index_users_on_token", using: :btree

end
