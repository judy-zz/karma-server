# == Schema Information
#
# Table name: buckets
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Bucket < ActiveRecord::Base
  validates_presence_of   :name
  validates_uniqueness_of :name
  default_scope :order => :name
  
  def to_param
    name
  end
  
end
