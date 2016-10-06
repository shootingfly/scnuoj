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

ActiveRecord::Schema.define(version: 20160928094310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "codes", force: :cascade do |t|
    t.text     "code"
    t.string   "language"
    t.integer  "problem_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "student_id"
  end

  create_table "contests", force: :cascade do |t|
    t.string   "contest_id"
    t.string   "title"
    t.string   "remark"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "duration"
    t.string   "status"
    t.string   "is_publish"
    t.string   "password"
    t.string   "publisher"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "managers", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "role"
    t.string "remark"
  end

  create_table "problems", force: :cascade do |t|
    t.string  "problem_id"
    t.string  "title"
    t.integer "ac"
    t.integer "submit"
    t.string  "description"
    t.string  "input"
    t.string  "output"
    t.string  "grade"
    t.string  "source"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "theme"
    t.string   "mode"
    t.string   "keymap"
    t.string   "lacale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ranks", force: :cascade do |t|
    t.string  "rank"
    t.string  "username"
    t.string  "classgrade"
    t.string  "dormitory"
    t.integer "ac"
    t.integer "submit"
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "run_id"
    t.string   "username"
    t.string   "problem_id"
    t.string   "result"
    t.string   "time_cost"
    t.string   "space_cost"
    t.string   "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_details", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "ac_record",  default: "", null: false
    t.integer  "wa",         default: 0,  null: false
    t.integer  "pe",         default: 0,  null: false
    t.integer  "re",         default: 0,  null: false
    t.integer  "ce",         default: 0,  null: false
    t.integer  "te",         default: 0,  null: false
    t.integer  "me",         default: 0,  null: false
    t.integer  "oe",         default: 0,  null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "ac",         default: 0,  null: false
    t.integer  "submit",     default: 0,  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "student_id"
    t.string "username"
    t.string "password_digest"
    t.string "classgrade"
    t.string "dormitory"
    t.string "phone"
    t.string "signature"
    t.string "auth_token"
  end

end
