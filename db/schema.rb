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

ActiveRecord::Schema.define(version: 20140926160435) do

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "team_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["name"], name: "index_projects_on_name", using: :btree
  add_index "projects", ["team_id"], name: "index_projects_on_team_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "leader_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["leader_id"], name: "index_teams_on_leader_id", using: :btree

  create_table "todos", force: true do |t|
    t.text     "content"
    t.integer  "assigned_to"
    t.date     "end_time"
    t.integer  "status",      default: 0
    t.integer  "author_id"
    t.integer  "priority",    default: 0
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "todos", ["assigned_to"], name: "index_todos_on_assigned_to", using: :btree
  add_index "todos", ["project_id"], name: "index_todos_on_project_id", using: :btree
  add_index "todos", ["status"], name: "index_todos_on_status", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
