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

ActiveRecord::Schema.define(version: 20150723145945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leagues", force: :cascade do |t|
    t.string  "name"
    t.integer "league_id", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.jsonb    "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "start_time"
    t.integer  "match_id"
  end

  add_index "matches", ["match_id"], name: "index_matches_on_match_id", unique: true, using: :btree
  add_index "matches", ["payload"], name: "index_matches_on_payload", using: :gin

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

  add_index "player_matches", ["account_id"], name: "index_player_matches_on_account_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "players", ["account_id"], name: "index_players_on_account_id", unique: true, using: :btree

  create_table "submissions", force: :cascade do |t|
    t.text     "content"
    t.boolean  "sub_in_review",      default: true
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "user_id"
    t.integer  "player_id"
    t.integer  "cached_votes_total", default: 0
    t.integer  "cached_votes_score", default: 0
    t.integer  "cached_votes_up",    default: 0
    t.integer  "cached_votes_down",  default: 0
  end

  add_index "submissions", ["cached_votes_down"], name: "index_submissions_on_cached_votes_down", using: :btree
  add_index "submissions", ["cached_votes_score"], name: "index_submissions_on_cached_votes_score", using: :btree
  add_index "submissions", ["cached_votes_total"], name: "index_submissions_on_cached_votes_total", using: :btree
  add_index "submissions", ["cached_votes_up"], name: "index_submissions_on_cached_votes_up", using: :btree

  create_table "team_matches", force: :cascade do |t|
    t.string   "team_name"
    t.integer  "team_id"
    t.integer  "league_id"
    t.integer  "match_id"
    t.integer  "start_time"
    t.integer  "duration"
    t.integer  "first_blood"
    t.boolean  "radiant"
    t.boolean  "radiant_win"
    t.integer  "captain_id"
    t.integer  "picks",       default: [],              array: true
    t.integer  "bans",        default: [],              array: true
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "team_matches", ["team_id"], name: "index_team_matches_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "roster",     default: [],              array: true
    t.boolean  "top_50"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "team_id"
    t.string   "id_roster",  default: [],              array: true
    t.integer  "rank"
  end

  add_index "teams", ["team_id"], name: "index_teams_on_team_id", unique: true, using: :btree

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

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
