class Website < ActiveRecord::Base
  
  has_many :admins_websites
  has_many :admins, :through => :admins_websites
  validates_presence_of :name, :url
  validates_format_of :url,
    :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix,
    :message => "needs to be a well-formed URL with protocol, eg. http://www.google.com"
  validates_uniqueness_of :url
  
  accepts_nested_attributes_for :admins
  
end

# == Schema Information
#
# Table name: websites
#
#  id         :integer         not null, primary key
#  url        :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
