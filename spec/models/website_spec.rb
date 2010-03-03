require 'spec_helper'

describe Website do
  before(:each) do
    @valid_attributes = {
      :url => "value for url",
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    Website.create!(@valid_attributes)
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

