require 'spec_helper'

describe Website do
  
  before(:each) do
    # Some of shoulda's matchers want to have at least one website already in the
    # test database. Sheesh, some people...
    Website.make
  end
  
  it { should have_many(:clients)  }
  it { should validate_presence_of(:name)   }
  it { should validate_presence_of(:url)    }
  it { should validate_uniqueness_of(:url)  }
  
  describe "#url" do
    it "should be valid when url is well-formed" do
      %w{
        http://www.google.com
        http://www.google.co.uk
      }.each do |valid_website|
        @website = Website.make(:url => valid_website)
        @website.should be_valid
      end
    end
    it "should fail when not formatted correctly" do
      %w{
        www.google.com
        www.google.co.uk
      }.each do |valid_website|
        @website = Website.new(:url => valid_website)
        @website.should_not be_valid
        @website.should have(1).errors_on(:url)
        @website.errors_on(:url).should include "needs to be a well-formed URL with protocol, eg. http://www.google.com"
      end
    end
  end
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

