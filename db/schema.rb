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

ActiveRecord::Schema.define(version: 20150918173926) do

  create_table "contributions", force: :cascade do |t|
    t.integer  "user_id",     limit: 4,                             null: false
    t.decimal  "latitude",                  precision: 9, scale: 6
    t.decimal  "longitude",                 precision: 9, scale: 6
    t.string   "title",       limit: 255,                           null: false
    t.text     "description", limit: 65535
    t.binary   "img",         limit: 65535
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "disasters", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "layers", force: :cascade do |t|
    t.integer  "org_id",     limit: 4,                         null: false
    t.decimal  "max_lat",              precision: 9, scale: 6
    t.decimal  "max_lon",              precision: 9, scale: 6
    t.decimal  "min_lat",              precision: 9, scale: 6
    t.decimal  "min_lon",              precision: 9, scale: 6
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,                         null: false
    t.decimal  "latitude",             precision: 9, scale: 6
    t.decimal  "longitude",            precision: 9, scale: 6
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name",        limit: 255, null: false
    t.string   "pw",          limit: 20,  null: false
    t.text     "description", limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "semicontributions", force: :cascade do |t|
    t.decimal  "max_lat",    precision: 9, scale: 6, null: false
    t.decimal  "max_lon",    precision: 9, scale: 6, null: false
    t.decimal  "min_lat",    precision: 9, scale: 6, null: false
    t.decimal  "min_lon",    precision: 9, scale: 6, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "semiwarnigs", force: :cascade do |t|
    t.decimal  "max_lat",    precision: 9, scale: 6
    t.decimal  "max_lon",    precision: 9, scale: 6
    t.decimal  "min_lat",    precision: 9, scale: 6
    t.decimal  "min_lon",    precision: 9, scale: 6
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "semiwarnings", force: :cascade do |t|
    t.decimal  "max_lat",    precision: 9, scale: 6, null: false
    t.decimal  "max_lon",    precision: 9, scale: 6, null: false
    t.decimal  "min_lat",    precision: 9, scale: 6, null: false
    t.decimal  "min_lon",    precision: 9, scale: 6, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 20, null: false
    t.string   "pw",         limit: 20, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "warnings", force: :cascade do |t|
    t.integer  "layer_id",    limit: 4,   null: false
    t.integer  "disaster_id", limit: 4,   null: false
    t.string   "apexes",      limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
