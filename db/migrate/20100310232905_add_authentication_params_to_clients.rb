class AddAuthenticationParamsToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :persistence_token, :string, :null => false
    add_column :clients, :api_key_salt, :string, :null => false
    rename_column :clients, :api_key, :crypted_api_key
  end

  def self.down
    rename_column :clients, :crypted_api_key, :api_key
    remove_column :clients, :api_key_salt
    remove_column :clients, :persistence_token
  end
end
