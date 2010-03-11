# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100310200819) do

  create_table "adjustments", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "bucket_id",  :null => false
    t.integer  "value",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",                                :null => false
    t.string   "crypted_password",                     :null => false
    t.string   "password_salt",                        :null => false
    t.string   "persistence_token",                    :null => false
    t.boolean  "super_admin",       :default => false, :null => false
  end

  add_index "admins", ["name"], :name => "index_admins_on_name"

  create_table "admins_websites", :force => true do |t|
    t.integer  "admin_id",   :null => false
    t.integer  "website_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins_websites", ["admin_id"], :name => "index_admins_websites_on_admin_id"
  add_index "admins_websites", ["website_id"], :name => "index_admins_websites_on_website_id"

  create_table "buckets", :force => true do |t|
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "hostname"
    t.string   "ip_address"
    t.string   "api_key"
    t.integer  "website_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients_websites", :force => true do |t|
    t.integer  "client_id",  :null => false
    t.integer  "website_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "permalink",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "websites", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
