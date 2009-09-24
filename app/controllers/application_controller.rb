# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  protected
  
  def rescue_action(exception)
    case exception
    when ActiveRecord::RecordNotFound
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

end

