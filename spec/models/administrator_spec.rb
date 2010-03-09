require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Admin do
  
  it { should have_and_belong_to_many(:websites)  }
  it { should validate_presence_of(:name)         }

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
