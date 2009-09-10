Given /^a bucket "([^\"]*)"$/ do |permalink|
  Bucket.create(:name => permalink)
end
