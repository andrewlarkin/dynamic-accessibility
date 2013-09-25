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

ActiveRecord::Schema.define(version: 20130925032729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "completed_tasks", force: true do |t|
    t.integer  "time"
    t.integer  "success_rate"
    t.integer  "participant_id"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "error_rate"
    t.integer  "activity_id"
    t.integer  "subjective_rating"
  end

  create_table "error_rates", force: true do |t|
    t.integer  "completed_task_id"
    t.integer  "error_id"
    t.integer  "error_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "errors", force: true do |t|
    t.string   "selector"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", force: true do |t|
    t.string   "email"
    t.string   "device"
    t.string   "crypted_password"
    t.integer  "prof_level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "age"
    t.integer  "tech_ability"
    t.string   "persistence_token"
    t.string   "password"
    t.boolean  "consent"
    t.datetime "last_request_at"
    t.boolean  "is_selected",       default: false
    t.string   "group"
  end

  create_table "sessions", force: true do |t|
    t.integer "participant_id"
    t.date    "expires"
    t.string  "token"
  end

  create_table "tasks", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "is_active"
    t.integer  "count"
  end

end
