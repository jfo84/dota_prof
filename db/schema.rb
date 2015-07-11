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

ActiveRecord::Schema.define(version: 20150711184051) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hero_lists", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "hero_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "start_time"
  end

  create_table "leagues", force: :cascade do |t|
    t.string  "name"
    t.integer "league_id", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.jsonb    "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_matches", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "hero_id"
    t.integer  "kills"
    t.integer  "deaths"
    t.integer  "assists"
    t.integer  "gpm"
    t.integer  "xpm"
    t.integer  "hero_damage"
    t.integer  "tower_damage"
    t.integer  "last_hits"
    t.integer  "denies"
    t.string   "inventory",    default: [],                 array: true
    t.boolean  "radiant",      default: false
    t.boolean  "radiant_win"
    t.integer  "start_time"
    t.integer  "match_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "roster",     default: [],              array: true
    t.boolean  "top_50"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "teams", ["name"], name: "index_teams_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
