Given /^a bucket "([^\"]*)"$/ do |permalink|
  Bucket.create(:permalink => permalink)
end

Given /^a bucket "([^\"]*)" that will fail to be deleted$/ do |permalink|
  bucket = mock_model(Bucket)
  bucket.stub!(:destroy => false, :permalink => permalink, :created_at => Time.now, :updated_at => Time.now)
  Bucket.stub!(:find_by_permalink!).and_return(bucket)
end
