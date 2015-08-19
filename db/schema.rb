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

ActiveRecord::Schema.define(version: 20150819170145) do

  create_table "collections", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.integer  "game_id",                null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "rating",     default: 0
    t.string   "platform"
  end

  add_index "collections", ["game_id"], name: "index_collections_on_game_id"
  add_index "collections", ["platform"], name: "index_collections_on_platform"
  add_index "collections", ["rating"], name: "index_collections_on_rating"
  add_index "collections", ["user_id"], name: "index_collections_on_user_id"

  create_table "games", force: :cascade do |t|
    t.integer  "platform_id"
    t.string   "name",               null: false
    t.string   "aliases"
    t.text     "description",        null: false
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.text     "themes"
    t.text     "developers"
    t.text     "release_platforms"
    t.date     "release_date"
    t.string   "api_endpoint"
    t.integer  "api_reference",      null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "games", ["api_endpoint"], name: "index_games_on_api_endpoint"
  add_index "games", ["api_reference"], name: "index_games_on_api_reference"
  add_index "games", ["name"], name: "index_games_on_name"
  add_index "games", ["platform_id"], name: "index_games_on_platform_id"

  create_table "games_genres", force: :cascade do |t|
    t.integer "game_id"
    t.integer "genre_id"
  end

  add_index "games_genres", ["game_id"], name: "index_games_genres_on_game_id"
  add_index "games_genres", ["genre_id"], name: "index_games_genres_on_genre_id"

  create_table "genres", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "url",           null: false
    t.integer  "api_reference", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "genres", ["api_reference"], name: "index_genres_on_api_reference"
  add_index "genres", ["name"], name: "index_genres_on_name"

  create_table "queries", force: :cascade do |t|
    t.string   "query",                  null: false
    t.integer  "count",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "queries", ["count"], name: "index_queries_on_count"
  add_index "queries", ["query"], name: "index_queries_on_query"

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "wikis", force: :cascade do |t|
    t.integer  "game_id"
    t.text     "body"
    t.text     "publishers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "wikis", ["game_id"], name: "index_wikis_on_game_id"

  create_table "wishlists", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "wishlists", ["user_id"], name: "index_wishlists_on_user_id"

end
