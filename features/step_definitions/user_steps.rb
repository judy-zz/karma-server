Given /^I have a user with permalink "([^\"]*)"$/ do |arg1|
  User.create(:permalink => arg1)
end
