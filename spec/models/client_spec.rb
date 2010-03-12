require 'spec_helper'

describe Client do
  before(:each) do
    @client = Client.make
  end
  
  it { should have_many(:clients_websites)  }
  it { should have_many(:websites).through(:clients_websites) }
  it { should validate_presence_of    :hostname   }
  it { should validate_presence_of    :ip_address }
  it { should validate_uniqueness_of  :hostname   }
  
  it "should validate the presence of the api_key" do
    @client.api_key = nil
    @client.should_not be_valid
    @client.errors.on(:api_key).should == "can't be blank"  
  end

  describe "#valid_ip_address" do
    
    describe "when the IP address is properly formed" do
      it "should return no ip_address errors" do
        @client.should be_valid
        @client.errors[:ip_address].should be_nil
      end
    end
    
    describe "when the IP address is improperly formed" do
      before(:each) do
        @client = Client.new(:ip_address => "10.0.0.500")
      end
      it "should return an ip_address error" do
        @client.should_not be_valid
        @client.errors[:ip_address].should == "is not valid"
      end
    end
  end
  
  describe "before creation and validation," do
    before(:each) do
      @client = Client.make_unsaved(:api_key => nil)
      @client.api_key.should be_nil
      @client.save!
    end
    it "the api key should be generated" do
      @client.api_key.should_not be_nil
    end
    it "the api key should be a MD5 hash (32 byte)" do
      @client.api_key.should match /^[\da-f]{32}$/
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

