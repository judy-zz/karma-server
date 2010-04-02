Given /^a website "([^\"]*)"$/ do |name|
  Website.create!(:name => name, :url => "http://www.#{name}.com", :id => 1)
end