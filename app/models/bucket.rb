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
    unless self.permalink.nil?
      if self.permalink.include?(".")
        errors.add(:permalink, "can't have a period")
      end
      if self.permalink.include?("/")
        errors.add(:permalink, "can't have a slash")
      end
      case self.permalink
      when "index", "new", "create", "edit", "update", "show"
        errors.add(:permalink, "can't be index, new, create, edit, update or show")
      end
    end
  end

end