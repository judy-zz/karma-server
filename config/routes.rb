ActionController::Routing::Routes.draw do |map|
  
  
  # GET /buckets(.json)
  map.with_options :controller => :buckets do |bucket|
    bucket.deleted_buckets '/buckets/deleted', :action => :deleted, :conditions => { :method => :get }
    bucket.restore_bucket '/buckets/:id/restore', :action => :restore, :conditions => { :method => :put }
  end
  map.resources :buckets
  
  map.with_options :controller => :users do |user|
    user.new_user '/users/new', :action => :new, :conditions => { :method => :get }
    user.connect '/users/:permalink.:format', :action => :create, :conditions => { :method => :put }
    user.user '/users/:permalink.:format', :action => :show, :conditions => { :method => :get }
  end
end
