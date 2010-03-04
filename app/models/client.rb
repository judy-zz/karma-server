# A Client is a web server that serves a Website. This represents the machines
# that exchange data with the Karma server.
class Client < ActiveRecord::Base
  belongs_to :website
end

# == Schema Information
#
# Table name: clients
#
#  id         :integer         not null, primary key
#  hostname   :string(255)
#  ip_address :string(255)
#  api_key    :string(255)
#  website_id :integer
#  created_at :datetime
#  updated_at :datetime
#

