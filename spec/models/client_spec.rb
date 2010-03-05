require 'spec_helper'

describe Client do
  before(:each) do
    @client = Client.make
  end

  it { should belong_to               :website    }
  it { should validate_presence_of    :hostname   }
  it { should validate_presence_of    :ip_address }
  it { should validate_uniqueness_of  :hostname   }
  
  describe "#valid_ip_address" do
    
    describe "when the IP address is properly formed" do
      it "should return no ip_address errors" do
        @client.should be_valid
        @client.errors[:ip_address].should be_nil
      end
    end
    
    describe "if the ip address is improperly formed" do
      before(:each) do
        @client = Client.new(:ip_address => "10.0.0.500")
      end
      it "should return an ip_address error" do
        @client.should_not be_valid
        @client.errors[:ip_address].should == "is not valid"
      end
    end

  end
  
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

