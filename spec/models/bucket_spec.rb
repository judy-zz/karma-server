# == Schema Information
#
# Table name: buckets
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Bucket do
  before(:each) do
    @bucket = Bucket.make
  end

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

end
