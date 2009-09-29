# == Schema Information
#
# Table name: buckets
#
#  id         :integer         not null, primary key
#  permalink  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Bucket do
  before(:each) do
    @bucket = Bucket.make
  end

  it { should validate_presence_of(:permalink) }
  it { should validate_uniqueness_of(:permalink) }

  describe "when there are some adjustments" do
    before(:each) do
      [-1, 3, 2, 3].each do |value|
        a = Adjustment.new :value => value
        a.user = User.make
        a.bucket = @bucket
        a.save!
      end
    end
  
    describe ":dependent => :destroy" do
      it "should delete all adjustments when bucket is deleted" do
        Adjustment.sum('value', :conditions => ["bucket_id = ?", @bucket.id]).should == 7
        @bucket.destroy
        Adjustment.sum('value', :conditions => ["bucket_id = ?", @bucket.id]).should == 0
      end
    end
  end

end
