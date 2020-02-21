class InitSchema < ActiveRecord::Migration[5.2]
  def up
    create_table "areas" do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    create_table "conversations" do |t|
      t.integer "sender_id"
      t.integer "recipient_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    create_table "favorites" do |t|
      t.integer "user_id", null: false
      t.integer "plan_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    create_table "jenres" do |t|
      t.string "name"
      t.string "image_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    create_table "messages" do |t|
      t.text "content"
      t.integer "user_id"
      t.integer "conversation_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["conversation_id"], name: "index_messages_on_conversation_id"
      t.index ["user_id"], name: "index_messages_on_user_id"
    end
    create_table "notifications" do |t|
      t.string "content"
      t.integer "user_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["user_id"], name: "index_notifications_on_user_id"
    end
    create_table "photos" do |t|
      t.integer "plan_id"
      t.string "image_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    create_table "plans" do |t|
      t.string "title"
      t.text "summary"
      t.integer "price"
      t.integer "member"
      t.datetime "start_time"
      t.datetime "end_time"
      t.date "plan_date"
      t.date "deadline"
      t.text "requirement"
      t.float "longitude"
      t.float "latitude"
      t.integer "restaurant_id", null: false
      t.integer "jenre_id", default: 1, null: false
      t.integer "user_id", null: false
      t.integer "area_id", default: 1, null: false
      t.integer "period_time"
      t.integer "status", default: 0
      t.boolean "is_holiday", default: false, null: false
      t.boolean "active", default: false, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "favorites_count", default: 0, null: false
    end
    create_table "reservations" do |t|
      t.integer "price"
      t.integer "user_id"
      t.integer "plan_id"
      t.integer "status", default: 0
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    create_table "restaurants" do |t|
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
    create_table "reviews" do |t|
      t.text "comment"
      t.integer "star", default: 1
      t.integer "plan_id"
      t.integer "reservation_id"
      t.integer "guest_id"
      t.integer "host_id"
      t.string "type"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["guest_id"], name: "index_reviews_on_guest_id"
      t.index ["host_id"], name: "index_reviews_on_host_id"
      t.index ["plan_id"], name: "index_reviews_on_plan_id"
      t.index ["reservation_id"], name: "index_reviews_on_reservation_id"
    end
    create_table "users" do |t|
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
      t.integer "jenre_id", default: 1, null: false
      t.boolean "active", default: false, null: false
      t.string "stripe_id"
      t.integer "unread", default: 0
      t.boolean "admin", default: false
      t.index ["email"], name: "index_users_on_email", unique: true
      t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
  end
end
