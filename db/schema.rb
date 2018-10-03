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

ActiveRecord::Schema.define(version: 2018_10_01_024710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "pokedexes", force: :cascade do |t|
    t.string "name"
    t.integer "base_health_point"
    t.integer "base_attack"
    t.integer "base_defence"
    t.integer "base_speed"
    t.string "element_type"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemon_battles", force: :cascade do |t|
    t.integer "pokemon1_id"
    t.integer "pokemon2_id"
    t.integer "current_turn"
    t.string "state"
    t.integer "pokemon_winner_id"
    t.integer "pokemon_loser_id"
    t.integer "experience_gain"
    t.integer "pokemon1_max_health_point"
    t.integer "pokemon2_max_health_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemon_skills", force: :cascade do |t|
    t.integer "skill_id"
    t.integer "pokemon_id"
    t.integer "current_pp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemons", force: :cascade do |t|
    t.integer "pokedex_id"
    t.string "name"
    t.integer "level"
    t.integer "max_health_point"
    t.integer "current_health_point"
    t.integer "attack"
    t.integer "defence"
    t.integer "speed"
    t.integer "current_experience"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.integer "power"
    t.integer "max_pp"
    t.string "element_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "pokemon_battles", "pokemons", column: "pokemon1_id"
  add_foreign_key "pokemon_battles", "pokemons", column: "pokemon2_id"
  add_foreign_key "pokemon_battles", "pokemons", column: "pokemon_loser_id"
  add_foreign_key "pokemon_battles", "pokemons", column: "pokemon_winner_id"
  add_foreign_key "pokemon_skills", "pokemons"
  add_foreign_key "pokemon_skills", "skills"
  add_foreign_key "pokemons", "pokedexes"
end
