Given /^an admin "([^\"]*)" with password "([^\"]*)"$/ do |name, password|
  Admin.create!(:name => name, :login => name, :password => password, :password_confirmation => password)
end

Given /^a superadmin "([^\"]*)" with password "([^\"]*)"$/ do |name, password|
  a = Admin.create!(:name => name, :login => name, :password => password, :password_confirmation => password)
  a.super_admin = true
  a.save
end

When /^I log in as "([^\"]*)" with password "([^\"]*)"$/ do |username, password|
  basic_auth(username, password)
end
