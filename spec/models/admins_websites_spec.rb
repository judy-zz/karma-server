require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AdminsWebsite do
  
  it { should belong_to(:website) }
  it { should belong_to(:admin)   }
  
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

