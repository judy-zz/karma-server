class CreateUsersWebsitesTable < ActiveRecord::Migration
  def self.up
    create_table :users_websites, :id => false, :force => true do |t|
      t.integer :user_id, :website_id
      t.timestamps
    end
  end

  def self.down
    drop_table :users_websites
  end
end
