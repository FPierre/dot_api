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

ActiveRecord::Schema.define(version: 20160605185743) do

  create_table "raspberries", force: :cascade do |t|
    t.string   "name",        limit: 255, null: false
    t.string   "ip_address",              null: false
    t.string   "mac_address",             null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "reminders", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "content",      limit: 75,              null: false
    t.integer  "priority",                 default: 3, null: false
    t.integer  "user_id",                              null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.datetime "displayed_at"
    t.integer  "duration",     limit: 2,   default: 1, null: false
    t.index ["user_id"], name: "index_reminders_on_user_id"
  end

  create_table "settings", force: :cascade do |t|
    t.boolean  "sarah_enabled",            default: true
    t.boolean  "twitter_enabled",          default: true
    t.boolean  "reminders_enabled",        default: true
    t.boolean  "weather_enabled",          default: true
    t.boolean  "weather_current_day_only", default: true
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "room_occupied",            default: false
    t.boolean  "screen_guest_enabled",     default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean  "approved",               default: false, null: false
    t.string   "authentication_token",   default: ""
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "firstname",                              null: false
    t.string   "lastname",                               null: false
    t.boolean  "admin",                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
