# == Schema Information
#
# Table name: buckets
#
#  id         :integer         not null, primary key
#  permalink  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Bucket < ActiveRecord::Base
  validates_presence_of   :permalink
  validates_uniqueness_of :permalink
  default_scope :order => :permalink
  
  
  
  def to_param
    permalink
  end

  def self.find_or_new_by_permalink permalink = ''
    found = find_by_permalink permalink
    found ? found : new(:permalink => permalink)
  end
  
end
