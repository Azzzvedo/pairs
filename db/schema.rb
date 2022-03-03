# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_02_141921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "recipient_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipient_id"], name: "index_chats_on_recipient_id"
    t.index ["sender_id"], name: "index_chats_on_sender_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "chat_id", null: false
    t.bigint "user_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "pairing_requests", force: :cascade do |t|
    t.bigint "pairing_session_id", null: false
    t.bigint "user_id", null: false
    t.boolean "approved"
    t.text "introduction"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pairing_session_id"], name: "index_pairing_requests_on_pairing_session_id"
    t.index ["user_id"], name: "index_pairing_requests_on_user_id"
  end

  create_table "pairing_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "activity"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.string "outcome"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false

    t.integer "time"
    t.index ["user_id"], name: "index_pairing_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "gender"
    t.text "bio"
    t.date "birth_date"
    t.string "competitiveness"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "chats", "users", column: "recipient_id"
  add_foreign_key "chats", "users", column: "sender_id"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
  add_foreign_key "pairing_requests", "pairing_sessions"
  add_foreign_key "pairing_requests", "users"
  add_foreign_key "pairing_sessions", "users"
end
