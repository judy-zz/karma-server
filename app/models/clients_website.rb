class ClientsWebsite < ActiveRecord::Base
  
  belongs_to :client
  belongs_to :website
  
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

