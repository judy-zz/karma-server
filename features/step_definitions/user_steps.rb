Given /^a user "([^\"]*)"$/ do |permalink|
  at_time(Time.utc(2009,9,9, 12,0,0)) do
    User.create(:permalink => permalink)
  end
end
