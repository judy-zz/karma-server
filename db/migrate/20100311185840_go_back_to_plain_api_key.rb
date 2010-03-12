class GoBackToPlainApiKey < ActiveRecord::Migration
  def self.up
    rename_column :clients, :crypted_api_key, :api_key
    remove_column :clients, :api_key_salt
    remove_column :clients, :persistence_token
  end

  def self.down
    add_column :clients, :persistence_token, :string, :null => false
    add_column :clients, :api_key_salt, :string, :null => false
    rename_column :clients, :api_key, :crypted_api_key
  end
end
