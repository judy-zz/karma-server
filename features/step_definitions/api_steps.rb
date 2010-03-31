Given /^a client with hostname "([^\"]*)" and api key "([^\"]*)"$/ do |hostname, api_key|
  website = Website.create!(:name => "westarete", :url => "http://www.westarete.com")
  client = Client.create!(:hostname => hostname, :ip_address => "127.0.0.1", :website => website)
  client.update_attribute(:api_key, api_key)
end

Given /^a website with name "([^\"]*)" and url "([^\"]*)"$/ do |name, url|
  Website.create!(:name => name, :url => url)
end

Given /^a client with hostname "([^\"]*)", api key "([^\"]*)", and website "([^\"]*)"$/ do |hostname, api_key, website|
  client = Client.create!(:hostname => hostname, :ip_address => "127.0.0.1", :website => Website.find_by_name(website))
  client.update_attribute(:api_key, api_key)
end

Given /^an admin with name "([^\"]*)" and password "([^\"]*)"$/ do |name, url|
  Admin.create!(:name => name, :password => password, :password_confirmation => password)
end

When /^I (GET|PUT|POST|DELETE|HEAD|OPTIONS|PROPFIND|TRACE) "([^\"]*)"( with body "(.*)")?$/ do |verb, path, clause, body|
  # Perform the action at a precise time, so we can anticipate the resulting
  # ActiveRecord timestamps.
  at_time(Time.utc(2009,9,9, 12,0,0)) do
    visit path, verb.downcase.to_sym, body
  end
end

When /^I (GET|PUT|POST|DELETE|HEAD|OPTIONS|PROPFIND|TRACE) "([^\"]*)" with a body like:$/ do |verb, path, body|
  # Perform the action at a precise time, so we can anticipate the resulting
  # ActiveRecord timestamps.
  at_time(Time.utc(2009,9,9, 12,0,0)) do
    visit path, verb.downcase.to_sym, body
  end
end

Then /^I should get a (\d+) ([\w\s]+) response$/ do |code, name|
  @response.code.should == code
end

Then /^the "(.*)" header should be "(.*)"$/ do |header_name, expected_value|
  @response.headers[header_name].should == expected_value
end

Then /^I should get an? (HTML|JSON|XML) response$/i do |format|
  content_type = case format.downcase
  when 'html' then 'text/html'
  when 'json' then 'application/json'
  when 'xml'  then 'application/xml'
  end
  @response.content_type.should == content_type
end

Then /^I should get a JSON response body like:$/ do |string|
  @response.content_type.should == 'application/json'
  expected = ActiveSupport::JSON.decode(string)
  actual   = ActiveSupport::JSON.decode(@response.body)
  actual.should == expected
end

Then /^I should get an XML response body like:$/ do |string|
  @response.content_type.should == 'application/xml'
  expected = Hash.from_xml(string)
  actual   = Hash.from_xml(@response.body)
  actual.should == expected
end

Then /^I should get an? (blank|empty) response body$/ do |empty|
  @response.body.should == " " 
end