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

ActiveRecord::Schema.define(version: 2018_08_26_155250) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "marks", force: :cascade do |t|
    t.bigint "post_id"
    t.integer "value", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_marks_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.text "content"
    t.inet "user_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "average_mark", default: 0.0, null: false
    t.integer "marks_count", default: 0, null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
    t.index ["user_ip", "user_id"], name: "index_posts_on_user_ip_and_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  add_foreign_key "marks", "posts"
  add_foreign_key "posts", "users"
end
