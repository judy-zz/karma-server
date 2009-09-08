class Bucket < ActiveRecord::Base
  validates_presence_of   :name
  validates_uniqueness_of :name
  default_scope :order => :name
  
  def to_param
    name
  end
  
end
