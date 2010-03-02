Given /^an admin "([^\"]*)"$/ do |name|
  Admin.create!(:name => name)
end
