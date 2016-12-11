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

ActiveRecord::Schema.define(version: 20161210074003) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "codes", force: :cascade do |t|
    t.text     "code"
    t.string   "language"
    t.integer  "problem_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "student_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "problem_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contest_problems", force: :cascade do |t|
    t.integer "contest_id"
    t.string  "problem_id"
    t.integer "time"
    t.integer "space"
    t.integer "ac"
    t.integer "submit"
    t.string  "description"
    t.string  "testdata"
  end

  create_table "contest_ranks", force: :cascade do |t|
    t.integer "contest_id"
    t.integer "team_id"
    t.integer "rank"
    t.integer "ac"
    t.integer "submit"
    t.integer "details",    array: true
  end

  create_table "contest_statuses", force: :cascade do |t|
    t.integer  "contest_id"
    t.string   "problem_id"
    t.string   "team_name"
    t.string   "result"
    t.integer  "time_cost"
    t.integer  "space_cost"
    t.integer  "code_length"
    t.datetime "created_at",  null: false
  end

  create_table "contests", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "status"
    t.string   "address"
    t.string   "remark"
    t.string   "title"
  end

  create_table "crono_jobs", force: :cascade do |t|
    t.string   "job_id",            null: false
    t.text     "log"
    t.datetime "last_performed_at"
    t.boolean  "healthy"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "crono_jobs", ["job_id"], name: "index_crono_jobs_on_job_id", unique: true, using: :btree

  create_table "managers", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "role"
    t.string "remark"
    t.string "auth_token"
  end

  create_table "problem_details", force: :cascade do |t|
    t.integer  "problem_id"
    t.integer  "ac",          default: 0, null: false
    t.integer  "submit",      default: 0, null: false
    t.integer  "ce",          default: 0, null: false
    t.integer  "me",          default: 0, null: false
    t.integer  "te",          default: 0, null: false
    t.integer  "re",          default: 0, null: false
    t.integer  "pe",          default: 0, null: false
    t.integer  "wa",          default: 0, null: false
    t.string   "last_person"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "problems", force: :cascade do |t|
    t.integer "problem_id"
    t.string  "title"
    t.string  "description"
    t.string  "source"
    t.integer "difficulty",  default: 1
    t.string  "testdata"
    t.integer "time"
    t.integer "space"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "theme"
    t.string   "mode"
    t.string   "keymap"
    t.string   "locale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ranks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "week_rank",   default: 9999, null: false
    t.integer "week_score",  default: 0
    t.integer "grade_rank",  default: 9999, null: false
    t.integer "grade_score", default: 0
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
    t.string   "student_id"
    t.string   "title"
  end

  create_table "teams", force: :cascade do |t|
    t.string "team_id"
    t.string "password_digest"
    t.string "team_name"
    t.string "school"
    t.string "reward_records",  array: true
    t.string "contest_records", array: true
  end

  create_table "user_details", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "wa",         default: 0,    null: false
    t.integer  "pe",         default: 0,    null: false
    t.integer  "re",         default: 0,    null: false
    t.integer  "ce",         default: 0,    null: false
    t.integer  "te",         default: 0,    null: false
    t.integer  "me",         default: 0,    null: false
    t.integer  "oe",         default: 0,    null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "ac",         default: 0,    null: false
    t.integer  "submit",     default: 0,    null: false
    t.integer  "score",      default: 0,    null: false
    t.integer  "rank",       default: 9999, null: false
    t.integer  "ac_record",  default: [],                array: true
  end

  create_table "user_logins", force: :cascade do |t|
    t.integer "user_id"
    t.string  "student_id"
    t.string  "password_digest"
    t.string  "token"
  end

  create_table "users", force: :cascade do |t|
    t.string "student_id"
    t.string "username"
    t.string "classgrade"
    t.string "dormitory"
    t.string "phone"
    t.string "signature"
    t.string "avatar"
    t.string "qq"
  end

end
