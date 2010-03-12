class RemoveAdminAuthorizations < ActiveRecord::Migration
  def self.up
    drop_table    :admins_websites
    remove_column :admins, :super_admin
  end

  def self.down
    add_column :admins, :super_admin, :boolean, :default => false, :null => false
    create_table "admins_websites", :force => true do |t|
      t.integer  "admin_id",   :null => false
      t.integer  "website_id", :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
