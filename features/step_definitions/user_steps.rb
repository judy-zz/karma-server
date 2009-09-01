Given /^I have a user with token "([^\"]*)"$/ do |arg1|
  User.create(:token => arg1)
end
