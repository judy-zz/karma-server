class AdjustmentBelongsToWebsite < ActiveRecord::Migration
  def self.up
    add_column :adjustments, :website_id, :integer, :null => true
  end

  def self.down
    remove_column :adjustments, :website_id
  end
end