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

ActiveRecord::Schema.define(version: 20161216121027) do

  create_table "activities", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.string   "category"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "location"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "activity_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "participations", force: :cascade do |t|
    t.string   "status"
    t.integer  "activity_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "from_userid"
    t.integer  "to_userid"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "replies", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "no"
    t.integer  "age"
    t.string   "sex"
    t.string   "college"
    t.string   "major"
    t.string   "school_year"
    t.text     "description"
    t.string   "salt"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
