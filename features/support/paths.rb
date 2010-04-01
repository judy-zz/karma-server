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
    when /^the tags page$/i
      tags_path
    when /^the new tag page$/i
      new_tag_path
    when /^the edit "(.*)" tag page$/i
      edit_tag_path(Tag.find_by_permalink($1))
    when /^the "(.*)" tag page$/i
      tag_path(Tag.find_by_permalink($1))
    when /^the admins page$/i
      admins_path
    when /^the new admin page$/i
      new_admin_path
    when /^the edit "(.*)" admin page$/i
      edit_admin_path(Admin.find_by_name($1))
    when /^the "(.*)" admin page$/i
      admin_path(Admin.find_by_name($1))
    when /^the websites page$/i
      websites_path
    when /^the new website page$/i
      new_website_path
    when /^the edit "(.*)" website page$/i
      edit_website_path(Website.find_by_name($1))
    when /^the "(.*)" website page$/i
      website_path(Website.find_by_name($1))
    when /^the edit tag page for "(.*)" "(.*)" tag$/i
      edit_website_tag_path(:website_id => Website.find_by_name($1).id, :id => $2)
    when /^the clients page$/i
      clients_path
    when /^the new client page$/i
      new_client_path
    when /^the edit "(.*)" client page$/i
      edit_client_path(Client.find_by_hostname($1))
    when /^the "(.*)" client page$/i
      client_path(Client.find_by_hostname($1))
    when /^the users page$/i
      users_path
    when /^the new user page$/i
      new_user_path
    when /^the edit "(.*)" user page$/i
      edit_user_path(User.find_by_permalink($1))
    when /^the "(.*)" user page$/i
      user_path(User.find_by_permalink($1))
    when /^the new adjustment page for (.*)'s (.*) tag$/
      new_adjustment_path(:user_permalink => $1, :tag_permalink => $2)
    when /^the adjustments page for (.*)'s (.*) tag$/
      adjustments_path(:user_permalink => $1, :tag_permalink => $2)
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
