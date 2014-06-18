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

ActiveRecord::Schema.define(version: 20140618200348) do

  create_table "assignments", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.string   "business_name"
    t.string   "billing_address"
    t.string   "street_address"
    t.string   "suit_unit"
    t.string   "city"
    t.string   "zip_code"
    t.integer  "country_id"
    t.integer  "state_id"
    t.string   "phone"
    t.string   "website"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "clients_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "title"
    t.string   "office_phone"
    t.string   "mobile_phone"
    t.string   "contact_method"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.datetime "deleted_at"
  end

  create_table "contacts_projects", force: true do |t|
    t.integer  "contact_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "business_name"
    t.string   "billing_address"
    t.string   "street_address"
    t.string   "suit_unit"
    t.string   "city"
    t.string   "zip_code"
    t.integer  "country_id"
    t.integer  "state_id"
    t.string   "phone"
    t.string   "website"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "client_id"
    t.datetime "deleted_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "number"
    t.integer  "customer_id"
    t.integer  "contact_id"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.datetime "deleted_at"
  end

  create_table "request_infos", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.text     "comments"
    t.text     "query"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_captcha_data", force: true do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "states", force: true do |t|
    t.integer  "country_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_logs", force: true do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.float    "logged"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "idle_time"
    t.datetime "deleted_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "email",                        default: "",    null: false
    t.string   "office_phone"
    t.string   "mobile_phone"
    t.string   "role"
    t.integer  "roles_mask"
    t.string   "encrypted_password",           default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
    t.string   "authentication_token"
    t.string   "otp_secret_key"
    t.integer  "second_factor_attempts_count", default: 0
    t.boolean  "password_change_required",     default: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.float    "billing_rate"
    t.datetime "deleted_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["otp_secret_key"], name: "index_users_on_otp_secret_key", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
