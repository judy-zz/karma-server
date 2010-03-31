class ClientsBelongToWebsite < ActiveRecord::Migration
  def self.up
    drop_table :clients_websites
  end

  def self.down
    create_table "clients_websites", :force => true do |t|
      t.integer  "client_id",  :null => false
      t.integer  "website_id", :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
  end
end
