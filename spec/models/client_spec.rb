require 'spec_helper'

describe Client do
  before(:each) do
    @client = Client.make
  end

  it { should belong_to :website }

end
