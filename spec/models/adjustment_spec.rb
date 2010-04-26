require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Adjustment do

  it { should validate_presence_of(:user_id )}
  it { should validate_presence_of(:tag_id  )}  
  it { should validate_presence_of(:value   )}
  it { should belong_to(:user     )}
  it { should belong_to(:tag      )}
  it { should belong_to(:website  )}

  describe "#after_save" do
    before do
      @user = User.make
      @website = Website.make
    end
    describe "when a user does not already belong to a website" do
      before do
        @website.users.any?{|user| user == @user }.should be_false
      end
      describe "and an adjustment is made" do
        before do
          @adjustment = Adjustment.make(:user => @user, :website => @website)
        end
        it "should create the user-website relationship" do
          @website.users.any?{|user| user == @user }.should be_true
        end
      end
    end
  end

end





# == Schema Information
#
# Table name: adjustments
#
#  id               :integer         not null, primary key
#  user_id          :integer         not null
#  tag_id           :integer         not null
#  value            :integer         not null
#  created_at       :datetime
#  updated_at       :datetime
#  website_id       :integer
#  action_timestamp :string(255)
#  object_uuid      :string(255)
#

