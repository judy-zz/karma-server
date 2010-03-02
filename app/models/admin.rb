class Admin < ActiveRecord::Base
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

