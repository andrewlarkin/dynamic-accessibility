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

ActiveRecord::Schema.define(version: 20130723042900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "completed_tasks", force: true do |t|
    t.integer  "rating"
    t.string   "feedback"
    t.boolean  "completed"
    t.integer  "time"
    t.integer  "success_rate"
    t.integer  "participant_id"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "username"
    t.string   "password"
    t.integer  "prof_level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "age"
    t.integer  "tech_ability"
    t.boolean  "is_deaf",             default: false
    t.boolean  "is_hard_of_hearing",  default: false
    t.boolean  "is_blind",            default: false
    t.boolean  "is_low_vision",       default: false
    t.boolean  "is_color_blind",      default: false
    t.boolean  "is_limited_mobility", default: false
    t.boolean  "is_other_disability", default: false
  end

  create_table "task_sets", force: true do |t|
    t.string   "name"
    t.string   "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "type"
    t.string   "description"
    t.integer  "task_set_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
