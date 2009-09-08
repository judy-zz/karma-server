class RemoveDeletedAtColumns < ActiveRecord::Migration
  def self.up
    remove_column :buckets, :deleted_at
  end

  def self.down
    add_column :buckets, :deleted_at, :datetime
  end
end
