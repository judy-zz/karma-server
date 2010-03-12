class AddAuthorizationParamsToAdmin < ActiveRecord::Migration
  class Admin < ActiveRecord::Base ; end
  def self.up
    Admin.destroy_all
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
