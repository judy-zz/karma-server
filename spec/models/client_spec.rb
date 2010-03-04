require 'spec_helper'

describe Client do
  before(:each) do
    @client = Client.make
  end

  it { should belong_to :website }

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

