require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Admin do

  it { should have_many(:admins_websites) }
  it { should have_many(:websites).through(:admins_websites) }
  it { should validate_presence_of(:name) }
  
  before(:each) do
    @valid_attributes = {
      :name => "Ash Skutches",
      :login => "ashley",
      :password => "ashley",
      :password_confirmation => "ashley"
    }
    @invalid_attributes = {
      :name => "Ash Skutches",
      :login => "ashley",
      :password => "ash",                 # Password is too short, and doesn't match.
      :password_confirmation => "ashley"
    }
  end

  describe "given valid attributes" do
    before(:each) do
      @admin = Admin.new(@valid_attributes)
    end
    it "should create an admin object" do
      @admin.save.should be_true
      @admin.should be_valid
    end
  end
  
  describe "given invalid attributes" do
    before(:each) do
      @admin = Admin.new(@invalid_attributes)
    end
    it "should not create an admin object" do
      @admin.save.should be_false
      @admin.should_not be_valid
    end
  end

end


# == Schema Information
#
# Table name: admins
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  login             :string(255)     not null
#  crypted_password  :string(255)     not null
#  password_salt     :string(255)     not null
#  persistence_token :string(255)     not null
#

