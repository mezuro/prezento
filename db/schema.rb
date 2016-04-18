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

ActiveRecord::Schema.define(version: 20160418192431) do

  create_table "kalibro_configuration_attributes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "kalibro_configuration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",                   default: true
  end

  create_table "project_attributes", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "image_url"
    t.integer  "user_id"
    t.boolean  "public",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "reading_group_attributes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "reading_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",           default: true
  end

  create_table "repository_attributes", force: :cascade do |t|
    t.integer  "repository_id"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "public",        default: true
  end

  add_index "repository_attributes", ["user_id"], name: "index_repository_attributes_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255, default: "", null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
