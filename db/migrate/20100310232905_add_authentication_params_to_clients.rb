class AddAuthenticationParamsToClients < ActiveRecord::Migration
  class Client < ActiveRecord::Base ; end
  def self.up
    Client.destroy_all
    add_column :clients, :persistence_token, :string, :null => false
    add_column :clients, :api_key_salt, :string, :null => false
    rename_column :clients, :api_key, :crypted_api_key
  end

  def self.down
    remove_column :clients, :persistence_token
    remove_column :clients, :api_key_salt
    rename_column :clients, :crypted_api_key, :api_key
  end
end
