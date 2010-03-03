class CreateAdministrators < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.string :name

      t.timestamps
    end
    add_index :admins, :name
  end

  def self.down
    remove_index :admins, :name
    drop_table :admins
  end
end
