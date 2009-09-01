class User < ActiveRecord::Base
  validates_presence_of   :permalink
  validates_uniqueness_of :permalink
  
  def to_param
    permalink
  end
end
