require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tag do
  before(:each) do
    @tag = Tag.make
    @website_tag = Tag.make(:website_id => Website.make)
  end

  it { should belong_to(:website) }
  it { should validate_presence_of(:permalink) }

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
  
  describe "#permalink" do
    describe "when a website is shared" do
      it "should return it's permalink attribute with 'karma:' namespace prepended" do
        @tag.permalink.should == "karma:" + @tag[:permalink].to_s
      end
    end
    describe "when a website is not shared" do
      it "should return it's permalink attribute" do
        @website_tag.permalink.should == @website_tag[:permalink].to_s
      end
    end
  end
  
  describe "#shared" do
    describe "when a tag is shared" do
      it "should return true" do
        @tag.shared?.should be_true
      end
    end
    describe "when a tag is not shared" do
      it "should return false" do
        @website_tag.shared?.should be_false
      end
    end
  end
  
  describe "#find_by_permalink" do
    describe "when a permalink passed in is nil" do
      it "should return nil" do
        Tag.find_by_permalink(nil).should be_nil
      end
    end

    describe "when the permalink has 'karma:' at it's head" do
      before(:each) do
        @permalink = "karma:" + @tag[:permalink]
      end
      it "should return a tag that matches the permalink string immediately following the 'karma:'" do
        Tag.find_by_permalink(@permalink).should == @tag
      end
    end

    describe "when the permalink doesn't have 'karma:' at its head" do
      before(:each) do
        @permalink = @tag[:permalink]
      end
      it "should return a tag that matches the permalink string" do
        Tag.find_by_permalink(@permalink).should == @tag
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
          @tag[:permalink] = p
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

