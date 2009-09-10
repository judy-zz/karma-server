Given /^I have a user with permalink "([^\"]*)"$/ do |arg1|
  User.create(:permalink => arg1)
end

Given /^a user "([^\"]*)"$/ do |permalink|
  User.create(:permalink => permalink)
end
