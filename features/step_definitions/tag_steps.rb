Given /^a tag "([^\"]*)"$/ do |permalink|
  Tag.create!(:permalink => permalink, :website_id => 1)
end

Given /^a tag "([^\"]*)" for "([^\"]*)"$/ do |permalink, website|
  Tag.create!(:permalink => permalink, :website_id => Website.find_by_name(website).id)
end
