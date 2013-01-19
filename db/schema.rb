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

ActiveRecord::Schema.define(:version => 20130119005102) do

  create_table "addresses", :force => true do |t|
    t.text     "text"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "auth_requirements", :force => true do |t|
    t.integer  "convention_id"
    t.string   "requirement"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "action"
    t.string   "model"
  end

  create_table "be_scheduled_rules", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body",             :default => ""
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "convention_linkables", :force => true do |t|
    t.integer  "convention_id"
    t.integer  "linkable_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "linkable_type"
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

  create_table "jobs", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "state"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.datetime "deadline"
  end

  create_table "maps", :force => true do |t|
    t.integer  "space_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "meets_occupancy_rules", :force => true do |t|
    t.string   "arrangement"
    t.integer  "capacity"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "periods", :force => true do |t|
    t.string   "name"
    t.integer  "convention_id"
    t.string   "special"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "phones", :force => true do |t|
    t.string   "number"
    t.string   "extension"
    t.string   "phone_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "phoneable_id"
    t.string   "phoneable_type"
  end

  create_table "profiles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reservations", :force => true do |t|
    t.string   "reservable_type"
    t.integer  "reservable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "inherit_time_span"
    t.integer  "reservee_id"
    t.string   "reservee_type"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "department"
    t.integer  "convention_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "profile_id"
  end

  create_table "rule_assignments", :force => true do |t|
    t.integer  "rule_id"
    t.string   "rule_type"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "removable"
  end

  create_table "schedule_reservables", :force => true do |t|
    t.string   "reservable_type"
    t.integer  "reservable_id"
    t.integer  "schedule_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "schedules", :force => true do |t|
    t.string   "name"
    t.integer  "time_span_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "convention_id"
  end

  create_table "spaces", :force => true do |t|
    t.string   "name"
    t.string   "venue_designated_name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "space_type"
    t.integer  "occupancy_seated"
    t.integer  "occupancy_standing"
    t.boolean  "inherit_address",       :default => true
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "time_spans", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "confidence"
    t.string   "time_spanable_type"
    t.integer  "time_spanable_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
    t.integer  "profile_id"
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
