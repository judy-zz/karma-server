# == Schema Information
#
# Table name: adjustments
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  bucket_id  :integer         not null
#  value      :integer         not null
#  created_at :datetime
#  updated_at :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Adjustment do

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:bucket_id) }
  it { should validate_presence_of(:value) }

end
