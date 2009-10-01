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
  has_many :adjustments, :dependent => :destroy
  validates_presence_of   :permalink
  validates_uniqueness_of :permalink
  default_scope :order => :permalink
  validate :valid_permalink
  
  attr_protected :created_at, :updated_at
  
  def to_param
    permalink
  end
  
  private
  def valid_permalink
    if !self.permalink.nil? and (self.permalink.include?(".") or self.permalink.include?("/"))
      errors.add(:permalink, "can't contain a period or a slash")
    end
  end

end