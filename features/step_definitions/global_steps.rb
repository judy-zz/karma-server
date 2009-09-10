Given /^I have a ([^\"]*) with attribute ([^\"]*) "([^\"]*)"$/ do |klass, method, value|
  eval("#{klass.camelize}.create(:#{method} => '#{value}')")
end

Given /^I have a ([^\"]*) with attributes ([^\"]*) "([^\"]*)" and ([^\"]*) "([^\"]*)"$/ do |klass, method, value, method2, value2|
  eval("#{klass.camelize}.create(:#{method} => '#{value}', :#{method2} => '#{value2}')")
end

When /^I edit the ([^\"]*) with ([^\"]*) "([^\"]*)"$/ do |klass, method, value|
  string_to_eval = "#{klass}.find(:first, :conditions => ['#{method} = ?','#{value}'])"
  class_object = eval(string_to_eval)
  visit "#{klass.pluralize.underscore}/#{value}/edit"
end

# JSON steps
When /^I POST to "(.*).json" with body "(.*)"$/ do |path, body|
  post "#{path}.json", body, :content_type => 'application/json'
end

When /^I PUT to "(.*).json" with body "(.*)"$/ do |path, body|
  put "#{path}.json", body, :content_type => 'application/json'
end

When /^I GET from "(.*).json"$/ do |path|
  get "#{path}.json", :content_type => 'application/json'
end

Then /^I should get a (\d+) ([\w\s]+) response$/ do |code, name|
  @response.code.should == code
end

Then /^the "(.*)" header should be "(.*)"$/ do |header_name, expected_value|
  @response.headers[header_name].should == expected_value
end

Then /^I should not see a "([^\"]*)" link$/ do |name|
   response.should_not have_tag("a", name)
end

Then /^I should see a "([^\"]*)" link$/ do |name|
 response.should have_tag("a", name)
end

When /^I click "([^\"]*)"$/ do |link_name|
  click_link link_name
end

Then /^I should see an error message$/ do
  flash[:failure].should_not be_nil
end

Then /^I should see an error explanation$/ do
  flash[:failure].should_not be_nil
end

Then /^there should be no errors$/ do
  flash[:failure].should be_nil
end

Then /^I should see a success message$/ do
  flash[:success].should_not be_nil
end

When /^I select "([^\"]*)"$/ do |value|
  select(value)
end

Then /^I should (still )?see "([^\"]*)" in "([^\"]*)"$/ do |still, value, field|
  field_labeled(field).value.should == value
end

Then /^I should not see "([^\"]*)" in "([^\"]*)"$/ do |value, field|
  field_labeled(field).value.should_not == value
end


# Some people ENJOY fixing bugs.
When /^I debug$/ do
  save_and_open_page
end