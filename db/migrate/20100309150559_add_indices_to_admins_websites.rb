class AddIndicesToAdminsWebsites < ActiveRecord::Migration
  def self.up
    add_index :admins_websites, :admin_id
    add_index :admins_websites, :website_id
  end

  def self.down
    remove_index :admins_websites, :website_id
    remove_index :admins_websites, :admin_id
    mind
  end
end
