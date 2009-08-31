Given /^I have a user with token "([^\"]*)"$/ do |arg1|
  User.create(:token => arg1)
end

When /^I POST to '(.*).json' with body '(.*)'$/ do |path, body|
  post "#{path}.json", body, :content_type => 'application/json'
end

Then /^I should get a (\d+) ([\w\s]+) response$/ do |code, name|
  @response.code.should == code
end

Then /^the '(.*)' header should be '(.*)'$/ do |header_name, expected_value|
  @response.headers[header_name].should == expected_value
end

When /^I GET from '\/users\/(.*).json'$/ do |name|
  get "users/#{name}", :content_type => 'application/json'
end