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

ActiveRecord::Schema.define(version: 20140824230734) do

  create_table "categories", force: true do |t|
    t.string   "titulo"
    t.string   "cor"
    t.text     "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "categories", ["user_id"], name: "index_categories_on_user_id"

  create_table "entries", force: true do |t|
    t.string   "titulo"
    t.text     "descricao"
    t.integer  "tipo"
    t.integer  "periodicidade"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "entries", ["category_id"], name: "index_entries_on_category_id"

  create_table "goals", force: true do |t|
    t.string   "titulo"
    t.text     "descricao"
    t.date     "inicio"
    t.date     "fim"
    t.integer  "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "category_id"
  end

  add_index "goals", ["category_id"], name: "index_goals_on_category_id"
  add_index "goals", ["user_id"], name: "index_goals_on_user_id"

  create_table "parts", force: true do |t|
    t.float    "valor"
    t.date     "data"
    t.integer  "confirmacao"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entry_id"
  end

  add_index "parts", ["entry_id"], name: "index_parts_on_entry_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
