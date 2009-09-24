ActionController::Routing::Routes.draw do |map|
  
  map.resources :buckets
  map.with_options :controller => :buckets do |bucket|
    bucket.connect '/buckets/:name', :action => :create, :conditions => { :method => :put }
  end
  
  map.with_options :controller => :adjustments do |m|
    m.new_user_bucket_adjustment '/users/:user_permalink/buckets/:bucket_permalink/adjustments/new.:format', :action => :new,    :conditions => { :method => :get }
    m.user_bucket_adjustments    '/users/:user_permalink/buckets/:bucket_permalink/adjustments.:format',     :action => :create, :conditions => { :method => :post }
    m.user_bucket_adjustments    '/users/:user_permalink/buckets/:bucket_permalink/adjustments.:format',     :action => :index,  :conditions => { :method => :get }
  end
  
  map.resources :users
end
