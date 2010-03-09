class AddSuperAdminToAdmin < ActiveRecord::Migration
  def self.up
    add_column :admins, :super_admin, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :admins, :super_admin
  end
end
