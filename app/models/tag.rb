class Tag < ActiveRecord::Base
  belongs_to :website
  has_many  :adjustments, :dependent => :destroy
  
  validates_presence_of   :permalink
  validates_uniqueness_of :permalink
  validate :valid_permalink
  
  default_scope :order => :permalink
  
  attr_protected :created_at, :updated_at
  
  def to_param
    permalink
  end
  
  # when tags are created, we check for a karma: in it's name, if so, the 
  # website id is allowed to be nil and is considered shared
  def shared?
    self.website_id == nil ? false : true
  end
  
  private
  
  def valid_permalink
    unless self.permalink.nil?
      if self.permalink.include?(".")
        errors.add(:permalink, "can't have a period")
      end
      if self.permalink.include?(" ")
        errors.add(:permalink, "can only submit 1 tag per adjustment")
      end
      if self.permalink.include?("/")
        errors.add(:permalink, "can't have a slash")
      end
      if self.permalink.split(':')[0] == 'karma'
        errors.add(:permalink, "karma namespace is reserved")
      end
      case self.permalink
      when "index", "new", "create", "edit", "update", "show"
        errors.add(:permalink, "can't be index, new, create, edit, update or show")
      end
    end
  end
end
# == Schema Information
#
# Table name: tags
#
#  id         :integer         not null, primary key
#  permalink  :string(255)
#  created_at :datetime
#  updated_at :datetime
#  website_id :integer
#

