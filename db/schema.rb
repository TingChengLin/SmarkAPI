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

ActiveRecord::Schema.define(:version => 20140228023301) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.integer  "user_id"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "token"
  end

  create_table "bookmarks", :force => true do |t|
    t.text     "url"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "collect_count", :default => 1
    t.integer  "vote_up",       :default => 0
    t.integer  "vote_down",     :default => 0
  end

  create_table "bookmarks_tags", :id => false, :force => true do |t|
    t.integer "bookmark_id"
    t.integer "tag_id"
  end

  create_table "bookmarks_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "bookmark_id"
  end

  create_table "klasses", :force => true do |t|
    t.string   "title"
    t.string   "speaker"
    t.text     "info"
    t.datetime "deadline"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title",      :limit => 128,        :default => "", :null => false
    t.text     "body",       :limit => 2147483647,                 :null => false
    t.integer  "timestamp",                        :default => 0,  :null => false
    t.integer  "klass_id"
    t.datetime "author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "tag_with_count"
    t.integer  "use_count",       :default => 0
    t.integer  "subscribe_count", :default => 0
  end

  create_table "tags_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "tag_id"
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
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "validation_code"
    t.integer  "following_count"
    t.integer  "follower_count"
    t.string   "img"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bookmark_id"
    t.string   "vote"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
