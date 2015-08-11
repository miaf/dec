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

ActiveRecord::Schema.define(version: 20150811090001) do

  create_table "galleries", force: :cascade do |t|
    t.integer  "service_id", limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "galleries", ["service_id"], name: "index_galleries_on_service_id", using: :btree

  create_table "gallery_languages", force: :cascade do |t|
    t.integer  "gallery_id",  limit: 4,   null: false
    t.string   "language",    limit: 2,   null: false
    t.string   "slug",        limit: 30,  null: false
    t.string   "description", limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "gallery_languages", ["gallery_id"], name: "index_gallery_languages_on_gallery_id", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string   "code",       limit: 2,  null: false
    t.string   "name",       limit: 30, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "service_languages", force: :cascade do |t|
    t.integer  "service_id",  limit: 4,     null: false
    t.string   "language",    limit: 2,     null: false
    t.string   "slug",        limit: 30,    null: false
    t.string   "description", limit: 255,   null: false
    t.text     "content",     limit: 65535, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "service_languages", ["service_id"], name: "index_service_languages_on_service_id", using: :btree
  add_index "service_languages", ["slug"], name: "index_service_languages_on_slug", using: :btree

  create_table "services", force: :cascade do |t|
    t.integer  "user_id",    limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                 limit: 50,                    null: false
    t.string   "last_name",                  limit: 50,                    null: false
    t.date     "date_of_birth",                                            null: false
    t.string   "gender",                     limit: 1,                     null: false
    t.string   "nationality",                limit: 20,                    null: false
    t.string   "country",                    limit: 30,                    null: false
    t.string   "email",                      limit: 100,                   null: false
    t.string   "phone",                      limit: 15,                    null: false
    t.string   "address",                    limit: 255,                   null: false
    t.string   "login_name",                 limit: 20,                    null: false
    t.string   "password_salt",              limit: 255,                   null: false
    t.string   "password_hash",              limit: 255,                   null: false
    t.boolean  "email_confirmed",                          default: false
    t.string   "confirm_token",              limit: 255
    t.datetime "confirmation_expires_after"
    t.string   "password_reset_token",       limit: 255
    t.datetime "password_expires_after"
    t.text     "description",                limit: 65535
    t.boolean  "activated",                                default: false
    t.string   "image_profile",              limit: 255
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["login_name"], name: "index_users_on_login_name", using: :btree

  add_foreign_key "galleries", "services"
  add_foreign_key "gallery_languages", "galleries"
  add_foreign_key "service_languages", "services"
  add_foreign_key "services", "users"
end
