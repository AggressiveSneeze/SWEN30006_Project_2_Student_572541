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

ActiveRecord::Schema.define(version: 20150419102043) do

  create_table "daily_readings", force: :cascade do |t|
    t.date     "date"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "daily_readings", ["location_id"], name: "index_daily_readings_on_location_id"

  create_table "dew_points", force: :cascade do |t|
    t.float    "dew_point"
    t.integer  "weather_reading_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "dew_points", ["weather_reading_id"], name: "index_dew_points_on_weather_reading_id"

  create_table "locations", force: :cascade do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rainfalls", force: :cascade do |t|
    t.float    "amount"
    t.integer  "weather_reading_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "rainfalls", ["weather_reading_id"], name: "index_rainfalls_on_weather_reading_id"

  create_table "temperatures", force: :cascade do |t|
    t.float    "temperature"
    t.float    "apparent_temperature"
    t.integer  "weather_reading_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "temperatures", ["weather_reading_id"], name: "index_temperatures_on_weather_reading_id"

  create_table "weather_readings", force: :cascade do |t|
    t.string   "source"
    t.text     "time"
    t.integer  "daily_reading_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "weather_readings", ["daily_reading_id"], name: "index_weather_readings_on_daily_reading_id"

  create_table "winds", force: :cascade do |t|
    t.string   "direction",          default: "NULL"
    t.float    "speed",              default: 0.0
    t.integer  "weather_reading_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "winds", ["weather_reading_id"], name: "index_winds_on_weather_reading_id"

end
