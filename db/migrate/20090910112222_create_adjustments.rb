class CreateAdjustments < ActiveRecord::Migration
  def self.up
    create_table :adjustments do |t|
      t.integer :user_id, :bucket_id, :null => false
      t.integer :value, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :adjustments
  end
end
