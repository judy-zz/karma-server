class Bucket < ActiveRecord::Base
  validates_presence_of   :name
  validates_uniqueness_of :name
  
  def self.deleted
    all(:conditions => ["deleted_at is not ?", nil])
  end
  
  def destroy
    self.deleted_at = Time.now
    save
  end
  
  def destroy!
    destroy
    save!
  end
end
