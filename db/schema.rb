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

ActiveRecord::Schema.define(version: 20150227213543) do

  create_table "authorizations", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "oauth_token"
    t.string   "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted"
  end

  create_table "avatars", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookings", force: true do |t|
    t.integer  "match_id"
    t.integer  "player_id"
    t.integer  "minute"
    t.integer  "plus_extra_time"
    t.boolean  "is_yellow_card"
    t.boolean  "is_red_card"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clubs", force: true do |t|
    t.string   "name",       limit: 500
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coaches", force: true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "dutchName"
    t.string   "isoAlpha2Code"
    t.string   "isoAlpha3Code"
    t.integer  "isoNumericCode"
    t.string   "FIFAcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cyclists", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "place_of_birth"
    t.decimal  "length",         precision: 10, scale: 0
    t.integer  "weight"
    t.integer  "number"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "groups", ["slug"], name: "index_groups_on_slug", unique: true, using: :btree

  create_table "lineups", force: true do |t|
    t.integer  "match_id"
    t.integer  "team_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "match_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: true do |t|
    t.integer  "number"
    t.integer  "matchtype_id"
    t.integer  "hometeam_id"
    t.integer  "awayteam_id"
    t.string   "homePlaceholder"
    t.string   "awayPlaceholder"
    t.integer  "homeScore"
    t.integer  "awayScore"
    t.integer  "stadium_id"
    t.integer  "referee_id"
    t.datetime "startDate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "matches", ["slug"], name: "index_matches_on_slug", unique: true, using: :btree

  create_table "matches_copy", force: true do |t|
    t.integer  "number"
    t.integer  "matchtype_id"
    t.integer  "hometeam_id"
    t.integer  "awayteam_id"
    t.string   "homePlaceholder"
    t.string   "awayPlaceholder"
    t.integer  "homeScore"
    t.integer  "awayScore"
    t.integer  "stadium_id"
    t.integer  "referee_id"
    t.datetime "startDate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participations", force: true do |t|
    t.integer  "user_id"
    t.integer  "poule_id"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "penalties", force: true do |t|
    t.integer  "match_id"
    t.integer  "player_id"
    t.boolean  "misses"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "firstName",     limit: 500
    t.string   "lastName",      limit: 500
    t.integer  "country_id"
    t.string   "position"
    t.integer  "club_id"
    t.integer  "number"
    t.boolean  "isCaptain"
    t.boolean  "isViceCaptain"
    t.integer  "caps"
    t.integer  "goals"
    t.date     "dateOfBirth"
    t.boolean  "inSquad"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "players", ["slug"], name: "index_players_on_slug", unique: true, using: :btree

  create_table "poules", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "is_protected"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "publicly_visible"
    t.decimal  "points",           precision: 6, scale: 3
  end

  create_table "predictions", force: true do |t|
    t.integer  "match_id"
    t.integer  "user_id"
    t.integer  "home_score"
    t.integer  "away_score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points"
  end

  create_table "referees", force: true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.date     "dateOfBirth"
    t.integer  "country_id"
    t.boolean  "isActive"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "scores", force: true do |t|
    t.integer  "player_id"
    t.integer  "match_id"
    t.integer  "minute"
    t.integer  "plus_extra_time"
    t.boolean  "is_penalty"
    t.boolean  "is_own_goal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "substitutes", force: true do |t|
    t.integer  "match_id"
    t.integer  "player_out_id"
    t.integer  "player_in_id"
    t.integer  "minute"
    t.integer  "plus_extra_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.integer  "country_id"
    t.integer  "FIFAranking"
    t.string   "associationFull",         limit: 4000
    t.string   "associationAbbreviation"
    t.integer  "coach_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.string   "placeholder"
    t.string   "slug"
    t.string   "appearances"
    t.string   "best_result"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "selection_type"
  end

  add_index "teams", ["slug"], name: "index_teams_on_slug", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
    t.string   "gender"
    t.string   "email"
    t.integer  "preferred_avatar"
    t.string   "public_name"
    t.string   "avatar_visibility"
    t.boolean  "deleted"
    t.datetime "last_visited"
    t.integer  "points"
  end

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.decimal  "latitude",             precision: 9, scale: 6
    t.decimal  "longitude",            precision: 9, scale: 6
    t.integer  "capacity"
    t.string   "wikipediaUrl"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "timezone"
    t.text     "description"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "slug"
  end

  add_index "venues", ["slug"], name: "index_venues_on_slug", unique: true, using: :btree

end
