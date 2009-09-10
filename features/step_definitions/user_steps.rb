Given /^a user "([^\"]*)"$/ do |permalink|
  User.create(:permalink => permalink)
end

Given /^the following users exist:$/ do |table|
  table.hashes.each do |hash|
    # Creating in multiple steps allows us to override the id.
    user = User.new(hash)
    user.id = hash[:id]
    user.save!
  end
end