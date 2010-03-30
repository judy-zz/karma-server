require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tag do
  before(:each) do
    @tag = Tag.make
  end

  it { should validate_presence_of(:permalink) }
  it { should validate_uniqueness_of(:permalink) }

  describe "when there are some adjustments" do
    before(:each) do
      [-1, 3, 2, 3].each do |value|
        a = Adjustment.new :value => value
        a.user = User.make
        a.tag = @tag
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

