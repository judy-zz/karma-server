require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Adjustment do

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:tag_id) }
  it { should validate_presence_of(:value) }
  it { should belong_to(:user) }
  it { should belong_to(:tag) }

end


# == Schema Information
#
# Table name: adjustments
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  tag_id     :integer         not null
#  value      :integer         not null
#  created_at :datetime
#  updated_at :datetime
#

