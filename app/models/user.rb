# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  permalink  :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates_presence_of   :permalink
  validates_uniqueness_of :permalink
  
  default_scope :order => :permalink
  
  def to_param
    permalink
  end
  
  # Return the total karma value for a given bucket for this user
  def karma_for(bucket)
    Adjustment.sum('value', :conditions => ["user_id = ? and bucket_id = ?", id, bucket.id])
  end
  
  # Return the total adjustment value for this user
  # described as the user's total karma
  def karma
    Adjustment.sum('value', :conditions => ["user_id = ?", id])
  end
  
end
