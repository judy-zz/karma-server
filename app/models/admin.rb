class Admin < ActiveRecord::Base
  
  has_many :admins_websites
  has_many :websites, :through => :admins_websites, :uniq => true
  validates_presence_of :name, :message => "can't be blank"
  
end


# == Schema Information
#
# Table name: admins
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

