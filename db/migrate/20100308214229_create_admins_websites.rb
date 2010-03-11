class CreateAdminsWebsites < ActiveRecord::Migration
  def self.up
    create_table :admins_websites do |t|
      t.integer :admin_id,    :null => false
      t.integer :website_id,  :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :admins_websites
  end
end
