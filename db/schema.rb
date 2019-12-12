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

ActiveRecord::Schema.define(version: 2019_12_12_162018) do

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jenres", force: :cascade do |t|
    t.string "name"
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.integer "plan_id"
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string "title"
    t.text "summary"
    t.integer "price"
    t.integer "member"
    t.datetime "start_time"
    t.datetime "end_time"
    t.date "plan_date"
    t.date "deadline"
    t.text "requirement"
    t.integer "restaurant_id", null: false
    t.integer "jenre_id", default: 1, null: false
    t.integer "user_id", null: false
    t.integer "area_id", default: 1, null: false
    t.integer "period_time"
    t.integer "status"
    t.boolean "is_holiday", default: false, null: false
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "price"
    t.integer "user_id"
    t.integer "plan_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.integer "budget"
    t.string "line"
    t.string "station"
    t.integer "walk"
    t.string "pc_url"
    t.string "image_url"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fullname"
    t.string "phone_number"
    t.text "description"
    t.string "image_id"
    t.integer "sex", default: 0, null: false
    t.integer "age"
    t.string "favorite_store"
    t.string "job"
    t.integer "jenre_id"
    t.boolean "active", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
