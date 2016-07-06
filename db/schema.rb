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

ActiveRecord::Schema.define(version: 20160705110401) do

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

  create_table "users", force: :cascade do |t|
    t.string "student_id"
    t.string "username"
    t.string "password"
    t.string "classgrade"
    t.string "dormitory"
    t.string "phone"
    t.string "signature"
  end

end
