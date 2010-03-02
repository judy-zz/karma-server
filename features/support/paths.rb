module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home page/
      root_path
    when /^the buckets page$/i
      buckets_path
    when /^the new bucket page$/i
      new_bucket_path
    when /^the edit "(.*)" bucket page$/i
      edit_bucket_path(Bucket.find_by_permalink($1))
    when /^the "(.*)" bucket page$/i
      bucket_path(Bucket.find_by_permalink($1))
    when /^the users page$/i
      users_path
    when /^the new user page$/i
      new_user_path
    when /^the edit "(.*)" user page$/i
      edit_user_path(User.find_by_permalink($1))
    when /^the "(.*)" user page$/i
      user_path(User.find_by_permalink($1))
    when /^the new adjustment page for (.*)'s (.*) bucket$/
      new_adjustment_path(:user_permalink => $1, :bucket_permalink => $2)
    when /^the adjustments page for (.*)'s (.*) bucket$/
      adjustments_path(:user_permalink => $1, :bucket_permalink => $2)
    when /^the new adjustment page for user (.*)$/
      new_user_adjustment_path(:user_permalink => $1)
    
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
