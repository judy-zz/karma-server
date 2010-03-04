class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :hostname, :ip_address, :api_key
      t.integer :website_id
      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
