Given /^a bucket "([^\"]*)"$/ do |permalink|
  Bucket.create(:permalink => permalink)
end

Given /^there are no buckets$/ do
  Bucket.delete_all
end
