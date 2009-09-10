Given /^a user "([^\"]*)"$/ do |permalink|
  User.create(:permalink => permalink)
end
