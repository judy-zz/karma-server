class AddAuthorizationParamsToAdmin < ActiveRecord::Migration
  def self.up
    add_column :admins, :login, :string, :null => false
    add_column :admins, :crypted_password, :string, :null => false
    add_column :admins, :password_salt, :string, :null => false
    add_column :admins, :persistence_token, :string, :null => false
  end

  def self.down
    remove_column :admins, :persistence_token
    remove_column :admins, :password_salt
    remove_column :admins, :crypted_password
    remove_column :admins, :login
  end
end
