# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  permalink  :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @user = User.make
    @plants =  Bucket.create! :permalink => "plants"
    @animals = Bucket.create! :permalink => "animals"
  end
  
  it { should validate_presence_of(:permalink) }
  it { should validate_uniqueness_of(:permalink) }

  describe "when there are no adjustments" do
    describe "#karma_for" do    
      it "should return 0" do
        @user.karma_for(@plants).should == 0
      end
    end
    
    describe "#karma" do
      it "should return 0" do
        @user.karma.should == 0
      end
    end
  end
  
  describe "when there are some adjustments" do
    before(:each) do
      [[-1, @plants], [3, @plants], [2, @plants], [3, @animals]].each do |value,bucket|
        a = Adjustment.new :value => value
        a.user = @user
        a.bucket = bucket
        a.save!
      end
    end
    
    describe "#karma_for" do    
      it "should return the sum the user's adjustments for the given bucket" do
        @user.karma_for(@plants).should == 4
      end
    end
    
    describe "#karma" do
      it "should return the sum of the user's adjustments for all buckets" do
        @user.karma.should == 7
      end
    end
    
    describe ":dependent => :destroy" do
      it "should delete all adjustments when user is deleted" do
        @user.destroy
        @user.karma.should == 0
      end
    end
  end

end
