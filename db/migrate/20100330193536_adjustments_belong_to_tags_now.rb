class AdjustmentsBelongToTagsNow < ActiveRecord::Migration
  def self.up
    rename_column :adjustments, :bucket_id, :tag_id
  end

  def self.down
    rename_column :adjustments, :tag_id, :bucket_id
  end
end
