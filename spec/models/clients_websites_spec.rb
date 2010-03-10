require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ClientsWebsite do

  it { should belong_to(:client)  }
  it { should belong_to(:website) }
  
end
# == Schema Information
#
# Table name: clients_websites
#
#  id         :integer         not null, primary key
#  client_id  :integer         not null
#  website_id :integer         not null
#  created_at :datetime
#  updated_at :datetime
#

