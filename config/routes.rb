ActionController::Routing::Routes.draw do |map|
  
  map.resources :buckets
  
  map.with_options :controller => :users do |user|
    user.new_user '/users/new', :action => :new, :conditions => { :method => :get }
    user.connect '/users/:permalink.:format', :action => :create, :conditions => { :method => :put }
    user.user '/users/:permalink.:format', :action => :show, :conditions => { :method => :get }
    user.users '/users', :action => :index, :conditions => { :method => :get }
  end
end
