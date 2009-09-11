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

  def self.find_or_new_by_name name = ''
    found = find_by_name name
    found ? found : new(:name => name)
  end
  
end
