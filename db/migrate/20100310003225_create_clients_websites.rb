class CreateClientsWebsites < ActiveRecord::Migration
  def self.up
    create_table :clients_websites do |t|
      t.integer :client_id  , :null => false
      t.integer :website_id , :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :clients_websites
  end
end
