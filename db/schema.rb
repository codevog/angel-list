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

ActiveRecord::Schema.define(version: 20141016133746) do

# Could not dump table "companies" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "location_tags", force: true do |t|
    t.integer  "ang_list_id",                            null: false
    t.string   "name",            limit: 50
    t.string   "display_name",    limit: 70
    t.integer  "process_status",             default: 0
    t.integer  "processed_users"
    t.integer  "statistic_users"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "last_page",                  default: 0
  end

  add_index "location_tags", ["ang_list_id"], name: "index_location_tags_on_ang_list_id", unique: true

end
