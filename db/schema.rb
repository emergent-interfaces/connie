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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120506193647) do

  create_table "be_scheduled_rules", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "convention_resourceables", :force => true do |t|
    t.integer  "convention_id"
    t.integer  "resourceable_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "resourceable_type"
  end

  create_table "conventions", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "duration_rules", :force => true do |t|
    t.integer  "min_duration"
    t.integer  "max_duration"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "is_related_rules", :force => true do |t|
    t.integer  "related_event_id"
    t.string   "relation"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "reservations", :force => true do |t|
    t.integer  "event_id"
    t.string   "reservable_type"
    t.integer  "reservable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rule_assignments", :force => true do |t|
    t.integer  "rule_id"
    t.string   "rule_type"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "removable"
  end

  create_table "spaces", :force => true do |t|
    t.string   "name"
    t.string   "venue_designated_name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "space_type"
  end

  create_table "tag_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id"], :name => "index_taggings_on_taggable_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "tag_group_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "tags", ["tag_group_id"], :name => "index_tags_on_tag_group_id"

  create_table "time_spans", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "confidence"
    t.string   "time_spanable_type"
    t.integer  "time_spanable_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

end
