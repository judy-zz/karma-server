require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tag do
  before(:each) do
    @tag = Tag.make
  end

  it { should belong_to(:website) }
  it { should validate_presence_of(:permalink) }
  it { should validate_uniqueness_of(:permalink) }

  describe "when there are some adjustments" do
    before(:each) do
      [-1, 3, 2, 3].each do |value|
        a = Adjustment.new :value => value
        a.user    = User.make
        a.tag     = @tag
        a.website = Website.make
        a.save!
      end
    end
  
    describe ":dependent => :destroy" do
      it "should delete all adjustments when tag is deleted" do
        Adjustment.sum('value', :conditions => ["tag_id = ?", @tag.id]).should == 7
        @tag.destroy
        Adjustment.sum('value', :conditions => ["tag_id = ?", @tag.id]).should == 0
      end
    end
  end

  describe "when a new tag is about to be saved" do
    describe "if a 'karma:' is present at the head of the permalink" do
      it "should return a permalink error" do
        bad_permalinks = [
          'karma',        # karma is reserved
          'karma:',       # karma is reserved
          'karma:new-tag' # karma is reserved
        ]
        bad_permalinks.each do |p|
          @tag.permalink = p
          @tag.should_not be_valid
          @tag.errors[:permalink].should include("karma namespace is reserved")
        end
      end
    end
    describe "if there isn't a karma: at the head of the permalink" do
      it "should return no permalink error" do
        @tag.should be_valid
      end
    end
  end

end

# == Schema Information
#
# Table name: tags
#
#  id         :integer         not null, primary key
#  permalink  :string(255)
#  created_at :datetime
#  updated_at :datetime
#  website_id :integer
#

