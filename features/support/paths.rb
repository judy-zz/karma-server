module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home page/
      root_path   
    # Add more page name => path mappings here
    when /^the "(.*)" bucket page$/i
      bucket_path(Bucket.find_by_permalink($1))
    when /^the edit "(.*)" bucket page$/i
      edit_bucket_path(Bucket.find_by_permalink($1))
    when /^the new adjustment page for (.*)'s (.*) bucket$/
      new_user_bucket_adjustment_path(:user_permalink => $1, :bucket_permalink => $2)
    when /^the adjustments page for (.*)'s (.*) bucket$/
      user_bucket_adjustments_path(:user_permalink => $1, :bucket_permalink => $2)
    else
      if path = match_rails_path_for(page_name) 
        path
      else 
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in features/support/paths.rb"
      end
    end
  end

  def match_rails_path_for(page_name)
    if page_name.match(/the (.*) page/)
      return send("#{$1.gsub(" ", "_")}_path") rescue nil
    end
  end

end

World(NavigationHelpers)
