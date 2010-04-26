# = Adjustment
#
# The adjustment model is used to store changes to karma. Each adjustment
# has a single positive or negative value, which is applied to a given user's
# tag.
#
class Adjustment < ActiveRecord::Base
  validates_presence_of :user_id, :tag_id, :value
  validates_numericality_of :value
  default_scope :order => :created_at
  
  belongs_to :user
  belongs_to :tag
  belongs_to :website
  
  attr_accessible :value
  
  def after_save
    if website && website.users.none? {|website_user| website_user == user}
      website.users << user
    end
  end
end






# == Schema Information
#
# Table name: adjustments
#
#  id               :integer         not null, primary key
#  user_id          :integer         not null
#  tag_id           :integer         not null
#  value            :integer         not null
#  created_at       :datetime
#  updated_at       :datetime
#  website_id       :integer
#  action_timestamp :string(255)
#  object_uuid      :string(255)
#

