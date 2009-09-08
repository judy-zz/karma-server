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
end
