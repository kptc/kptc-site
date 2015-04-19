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

ActiveRecord::Schema.define(version: 20150419170642) do

  create_table "player_sessions", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "session_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "rank_letter"
    t.integer  "rank_number"
  end

  add_index "player_sessions", ["player_id"], name: "index_player_sessions_on_player_id"
  add_index "player_sessions", ["session_id"], name: "index_player_sessions_on_session_id"

  create_table "players", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "role"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "gender"
  end

  add_index "players", ["email"], name: "index_players_on_email", unique: true
  add_index "players", ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true

  create_table "session_times", force: :cascade do |t|
    t.integer  "session_id"
    t.datetime "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "session_times", ["session_id"], name: "index_session_times_on_session_id"

  create_table "session_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.integer  "session_type_id"
    t.string   "time_of_day"
    t.string   "day_of_week"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "gender"
    t.boolean  "allow_both_genders", default: false
  end

  create_table "sub_preferences", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sub_preferences", ["player_id"], name: "index_sub_preferences_on_player_id"
  add_index "sub_preferences", ["session_id"], name: "index_sub_preferences_on_session_id"

end
