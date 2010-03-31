class AddOptionalFieldsToAdjustments < ActiveRecord::Migration
  def self.up
    add_column :adjustments, :action_timestamp, :string, :null => true
    add_column :adjustments, :object_uuid     , :string, :null => true
  end

  def self.down
    remove_column :adjustments, :object_uuid
    remove_column :adjustments, :action_timestamp
  end
end