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

ActiveRecord::Schema.define(version: 20141104235216) do

  create_table "attendances", force: true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status"
    t.integer  "position"
  end

  add_index "attendances", ["group_id", "user_id"], name: "index_attendances_on_group_id_and_user_id", unique: true
  add_index "attendances", ["group_id"], name: "index_attendances_on_group_id"
  add_index "attendances", ["user_id"], name: "index_attendances_on_user_id"

  create_table "groups", force: true do |t|
    t.text     "title"
    t.datetime "when"
    t.integer  "seats"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.integer  "karma"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
