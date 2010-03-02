Given /^an administrator "([^\"]*)"$/ do |name|
  Administrator.create!(:name => name)
end
