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

ActiveRecord::Schema.define(version: 20150926165510) do

  create_table "coin_alerts", force: :cascade do |t|
    t.integer  "coin_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "status"
  end

  add_index "coin_alerts", ["coin_id"], name: "index_coin_alerts_on_coin_id"
  add_index "coin_alerts", ["user_id"], name: "index_coin_alerts_on_user_id"

  create_table "coins", force: :cascade do |t|
    t.string   "creation_location"
    t.string   "code"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "creator_id"
    t.string   "city"
    t.string   "state"
    t.string   "description"
  end

  create_table "create_coin_alerts", force: :cascade do |t|
    t.integer  "coin_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "create_coin_alerts", ["coin_id"], name: "index_create_coin_alerts_on_coin_id"
  add_index "create_coin_alerts", ["user_id"], name: "index_create_coin_alerts_on_user_id"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.text     "description"
    t.string   "photo_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "creator_id"
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  create_table "moments", force: :cascade do |t|
    t.integer  "coin_id"
    t.text     "description"
    t.date     "date"
    t.string   "city"
    t.string   "state"
    t.string   "location"
    t.string   "photo_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "receiver_id"
    t.integer  "giver_id"
    t.boolean  "alert_status"
  end

  add_index "moments", ["coin_id"], name: "index_moments_on_coin_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "tagline"
    t.string   "profile_url"
    t.text     "location"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image_url"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
