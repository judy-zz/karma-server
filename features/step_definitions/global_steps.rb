Given /^there are no ([^\"]*)$/ do |objects|
  eval(objects.classify).destroy_all
end

Given /^I have (a|an) ([^\"]*) with attribute ([^\"]*) "([^\"]*)"$/ do |blank, klass, method, value|
  eval("#{klass.camelize}.create!(:#{method} => '#{value}')")
end

Given /^I have (a|an) ([^\"]*) with attributes ([^\"]*) "([^\"]*)" and ([^\"]*) "([^\"]*)"$/ do |blank, klass, method, value, method2, value2|
  eval("#{klass.camelize}.create!(:#{method} => '#{value}', :#{method2} => '#{value2}')")
end

Given /^I have (a|an) ([^\"]*) with attributes ([^\"]*) "([^\"]*)", ([^\"]*) "([^\"]*)", and ([^\"]*) "([^\"]*)"$/ do |blank, klass, method, value, method2, value2, method3, value3|
  eval("#{klass.camelize}.create!(:#{method} => '#{value}', :#{method2} => '#{value2}', :#{method3} => '#{value3}')")
end

Given /^I have (a|an) ([^\"]*) with attributes ([^\"]*) "([^\"]*)", ([^\"]*) "([^\"]*)", ([^\"]*) "([^\"]*)", and ([^\"]*) "([^\"]*)"$/ do |blank, klass, method, value, method2, value2, method3, value3, method4, value4|
  eval("#{klass.camelize}.create!(:#{method} => '#{value}', :#{method2} => '#{value2}', :#{method3} => '#{value3}', :#{method4} => '#{value4}')")
end

When /^I edit the ([^\"]*) with ([^\"]*) "([^\"]*)"$/ do |klass, method, value|
  string_to_eval = "#{klass}.find(:first, :conditions => ['#{method} = ?','#{value}'])"
  class_object = eval(string_to_eval)
  visit "#{klass.pluralize.underscore}/#{value}/edit"
end

Given /^the following (\w+):$/ do |table_name, table|
  klass = table_name.classify.constantize
  table.hashes.each do |hash|
    object = klass.new
    hash.each do |key, value|
      object[key] = value   # Must explicitly set the id to override it.
    end
    object.save!
  end
end

Then /^I should not see a "([^\"]*)" link$/ do |name|
   response.should_not have_tag("a", name)
end

Then /^I should see a "([^\"]*)" link$/ do |name|
 response.should have_tag("a", name)
end

Then /^I should see "([^\"]*)" in "([^\"]*)"$/ do |value, tag|
 response.should have_tag(tag, value)
end

When /^I click "([^\"]*)"$/ do |link_name|
  click_link link_name
end

Then /^I should see an error message$/ do
  flash[:failure].should_not be_nil
end

Then /^I should see an error explanation/ do
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

Then /^I should (still )?see "([^\"]*)" in the "([^\"]*)" field$/ do |still, value, field|
  field_labeled(field).value.should == value
end

Then /^I should not see "([^\"]*)" in the "([^\"]*)" field$/ do |value, field|
  field_labeled(field).value.should_not == value
end

When /^I debug$/ do
  save_and_open_page
end