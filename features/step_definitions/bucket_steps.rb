Given /^a bucket "([^\"]*)"$/ do |permalink|
  Bucket.create(:permalink => permalink)
end
