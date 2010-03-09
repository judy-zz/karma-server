class AdminsWebsites < ActiveRecord::Base
  belongs_to :admin
  belongs_to :website
end

# == Schema Information
#
# Table name: admins_websites
#
#  id         :integer         not null, primary key
#  admin_id   :integer         not null
#  website_id :integer         not null
#  created_at :datetime
#  updated_at :datetime
#

