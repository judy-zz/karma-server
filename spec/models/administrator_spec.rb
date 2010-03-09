require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Admin do

  it { should validate_presence_of(:name) }
  
  describe "#role" do
    describe "when super admin is false" do
      before(:each) do
        @admin = Admin.make(:super_admin => false)
      end
      it "it should be 'Admin' " do
        @admin.role.should == 'Admin'
      end
    end
    
    describe "when super_admin is true" do
      before(:each) do
        @admin = Admin.make(:super_admin => true)
      end
      it "it should be 'Super Admin'" do
        @admin.role.should == 'Super Admin'
      end
    end
  end

end

# == Schema Information
#
# Table name: admins
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
