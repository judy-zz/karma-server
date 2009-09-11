class ChangeBucketNameToPermalink < ActiveRecord::Migration
  def self.up
    rename_column :buckets, :name, :permalink
  end

  def self.down
    rename_column :buckets, :permalink, :name    
  end
end
