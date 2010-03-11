# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_admin, :require_super_admin
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
      if @current_admin = Admin.find_by_login(username)
        @current_admin.valid_password?(password)
      else
        false
      end
    end
  end
  
  def current_admin
    return @current_admin if defined?(@current_admin)
    authenticate
  end
  
  def require_super_admin
    unless current_admin && current_admin.super_admin
      flash[:failure] = "You must have insufficient privileges"
      redirect_to :back
      return false
    end
  end

end