Given /^a tag "([^\"]*)"$/ do |permalink|
  Tag.create!(:permalink => permalink)
end
