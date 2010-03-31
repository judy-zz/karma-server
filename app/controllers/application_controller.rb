# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_admin, :current_admin_or_client, :require_super_admin
  before_filter :authenticate
  
  # Turning off forgery protection for now since it was unexpectedly messing
  # with json API requests. Not sure why.
  # protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

protected
    
  def rescue_action(exception)
    case exception
    when ActiveRecord::RecordNotFound, ActionController::RoutingError
      render_404
    else
      super
    end
  end
  
  def render_404
    respond_to do |format|
      format.html { render :file => "#{RAILS_ROOT}/public/404.html", :status => :not_found }
      format.json { render :nothing => true, :status => :not_found }
      format.xml  { render :nothing => true, :status => :not_found }
    end
    true
  end
  
private

  def authenticate

    authenticate_or_request_with_http_basic do |username, password|
      # Start off by making sure nobody is logged in.
      @current_admin  = nil
      @current_client = nil
      # Determine what kind of account we're authenticating.
      if username.blank? 
        # We're authenticating a client.
        if params["format"] && (params["format"] == "xml" || params["format"] == "json")
          @current_client = Client.find(:first, :conditions => {
            :ip_address => request.remote_ip, 
            :api_key    => password})
        end
      else
        # We're authenticating an admin.
        admin = Admin.find_by_login(username)
        if admin && admin.valid_password?(password)
          @current_admin = admin
        end
      end
    end
  end
  
  def current_admin
    return @current_admin if defined?(@current_admin)
    authenticate
  end
  
  def current_client
    return @current_client if defined?(@current_client)
    return nil
  end

end