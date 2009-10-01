# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def changed_permalink object
    object.changed.include?('permalink') ? object.permalink_was : object.permalink
  end
  
end
