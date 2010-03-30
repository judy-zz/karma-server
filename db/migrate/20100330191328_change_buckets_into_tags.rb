class ChangeBucketsIntoTags < ActiveRecord::Migration
  def self.up
    rename_table :buckets, :tags
    add_column :tags, :website_id, :integer
  end

  def self.down
    remove_column :tags, :website_id
    rename_table :tags, :buckets
  end
end
