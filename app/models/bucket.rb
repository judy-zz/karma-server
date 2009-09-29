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
  validate :valid_permalink
  
  
  def to_param
    permalink
  end
  
  private
  def valid_permalink
    if !self.permalink.nil? and (self.permalink.include?(".") or self.permalink.include?("/"))
      errors.add(:permalink, "cannot contain a period or a slash")
    end
  end

end