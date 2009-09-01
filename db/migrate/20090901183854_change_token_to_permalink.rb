class ChangeTokenToPermalink < ActiveRecord::Migration
  def self.up
    rename_column :users, :token, :permalink
  end

  def self.down
    rename_column :users, :permalink, :token
  end
end
