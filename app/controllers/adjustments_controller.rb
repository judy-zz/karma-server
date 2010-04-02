class AdjustmentsController < ApplicationController
  include AdjustmentsHelper
  before_filter :find_user_and_tag

  # List all adjustments.
  #
  #   GET /users/:user_permalink/tags/:tag_permalink/adjustments.html
  #   GET /users/:user_permalink/tags/:tag_permalink/adjustments.xml
  #   GET /users/:user_permalink/tags/:tag_permalink/adjustments.json
  def index
    if @user and @tag
      @adjustments = Adjustment.find(:all, :conditions => {:user_id => @user.id, :tag_id => @tag.id})
      respond_to do |format|
        format.html
        format.json { render :json  => adjustments_to_json(@adjustments) }
        format.xml  { render :xml   => adjustments_to_xml(@adjustments) }
      end
    # If tag permalink is given but not found, do not run!
    elsif @user && ! params[:tag_permalink] 
      @adjustments = Adjustment.find(:all, :conditions => {:user_id => @user.id})
      respond_to do |format|
        format.html
        format.json { render :json  => adjustments_to_json(@adjustments) }
        format.xml  { render :xml   => adjustments_to_xml(@adjustments) }
      end
    else
      render :nothing => true, :status => :not_found
    end
  end
  
  # Display the template for creating a new adjustment.
  #
  #   GET /users/:user_permalink/tags/:tag_permalink/adjustments/new.html
  #   GET /users/:user_permalink/tags/:tag_permalink/adjustments/new.xml
  #   GET /users/:user_permalink/tags/:tag_permalink/adjustments/new.json
  def new
    @adjustment = Adjustment.new
    @adjustment.user = @user
    @adjustment.tag = @tag
    respond_to do |format|
      format.html
      format.json{ render :json => adjustment_to_json(@adjustment) }
      format.xml{  render :xml  => adjustment_to_xml(@adjustment)  }
    end
  end
  
  # Create a new adjustment
  #
  #   POST /users/:user_permalink/tags/:tag_permalink/adjustments.html
  #   POST /users/:user_permalink/tags/:tag_permalink/adjustments.xml
  #   POST /users/:user_permalink/tags/:tag_permalink/adjustments.json
  def create
    if params[:adjustment] and params[:adjustment][:tag_id]
      @tag = Tag.find(params[:adjustment][:tag_id])
    end
    @adjustment = Adjustment.new(params[:adjustment])
    @adjustment.user = @user
    @adjustment.tag  = @tag
    # A timestamp of the action a user took to trigger the adjustment. Optional and semantically
    # unbiased
    @adjustment.action_timestamp = params[:action_timestamp] if params[:action_timestamp]
    # An identifier to an object that relates to the adjustment request. Optional and semantically
    # unbiased
    @adjustment.object_uuid      = params[:object_uuid]      if params[:object_uuid]
    # Client adjustments have their websites saved, Admins do not
    @adjustment.website_id       = current_client.website.id if current_client
    if @adjustment.save
      flash[:success] = "Karma was successfully adjusted"
      respond_to do |format|
        format.html{ redirect_to adjustments_path(@user, @tag) }
        format.json{ render :json => adjustment_to_json(@adjustment), :status => :created }
        format.xml{  render :xml  => adjustment_to_xml(@adjustment), :status => :created }
      end
    else
      flash[:failure] = "Karma failed to be adjusted"
      respond_to do |format|
        format.html{ render :new }
        format.json{ render :json => @adjustment.errors, :status => :unprocessable_entity }
        format.xml{  render :xml  => @adjustment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # Show a particular user.
  #
  #   GET /users/:user_permalink/tags/:tag_permalink/adjustments/:id.xml
  #   GET /users/:user_permalink/tags/:tag_permalink/adjustments/:id.json
  def show
    @adjustment = Adjustment.find params[:id]
    if @adjustment
      respond_to do |format|
        format.json { render :json => adjustment_to_json(@adjustment) }
        format.xml  { render :xml  => adjustment_to_xml(@adjustment)  }
      end
    else
      render "404.html", :status => :not_found
    end
  end
  
  # Delete a particular tag from the database.
  #
  #   DELETE /users/:user_permalink/tags/:tag_permalink/adjustments/:id.html
  #   DELETE /users/:user_permalink/tags/:tag_permalink/adjustments/:id.xml
  #   DELETE /users/:user_permalink/tags/:tag_permalink/adjustments/:id.json
  def destroy
    @adjustment = Adjustment.find params[:id]
    if @adjustment.destroy
      flash[:success] = "Adjustment was successfully destroyed."
      respond_to do |format|
        format.json { render :json => adjustment_to_json(@adjustment) }
        format.xml  { render :xml  => adjustment_to_xml(@adjustment) }
      end
    else
      respond_to do |format|
        format.json { render :nothing => true }
        format.xml  { render :text => "yo" }
      end
    end
      
  end

  private
  
  def find_user_and_tag
    @user = User.find_by_permalink!(params[:user_permalink])
    @tag = Tag.find_by_permalink(params[:tag_permalink])
    if @tag.nil? && params[:tag_permalink] && current_client
      @tag = Tag.create!(:permalink => params[:tag_permalink], :website_id => current_client.website.id)
    end
  end

  def find_website_if_client
    @website = current_client.websites.first if current_client
  end

end