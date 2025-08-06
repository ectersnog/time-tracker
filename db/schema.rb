# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_31_012819) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "line_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "list_id", null: false
    t.string "task", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_line_items_on_list_id"
    t.index ["task"], name: "index_line_items_on_task", unique: true
  end

  create_table "lists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_lists_on_name", unique: true
  end

  create_table "time_entries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "line_item_id", null: false
    t.datetime "started_at", null: false
    t.datetime "stopped_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_item_id"], name: "index_time_entries_on_line_item_id"
  end

  add_foreign_key "line_items", "lists"
  add_foreign_key "time_entries", "line_items"
end
