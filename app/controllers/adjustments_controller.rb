class AdjustmentsController < ApplicationController
  include AdjustmentsHelper
  before_filter :find_user_and_bucket

  # List all adjustments.
  #
  #   GET /users/:user_permalink/buckets/:bucket_permalink/adjustments.html
  #   GET /users/:user_permalink/buckets/:bucket_permalink/adjustments.xml
  #   GET /users/:user_permalink/buckets/:bucket_permalink/adjustments.json
  def index
    if @user and @bucket
      @adjustments = Adjustment.find(:all, :conditions => {:user_id => @user.id, :bucket_id => @bucket.id})
      respond_to do |format|
        format.html
        format.json { render :json  => adjustments_to_json(@adjustments) }
        format.xml  { render :xml   => adjustments_to_xml(@adjustments) }
      end
    else
      respond_to do |format|
        format.json { render :json => :nothing, :status => :not_found }
        format.xml{ render :xml => :nothing, :status => :not_found }
      end
    end
  end
  
  # Display the template for creating a new adjustment.
  #
  #   GET /users/:user_permalink/buckets/:bucket_permalink/adjustments/new.html
  #   GET /users/:user_permalink/buckets/:bucket_permalink/adjustments/new.xml
  #   GET /users/:user_permalink/buckets/:bucket_permalink/adjustments/new.json
  def new
    @adjustment = Adjustment.new
    @adjustment.user = @user
    @adjustment.bucket = @bucket
    respond_to do |format|
      format.html
      format.json{ render :json => adjustment_to_json(@adjustment) }
      format.xml{  render :xml  => adjustment_to_xml(@adjustment)  }
    end
  end
  
  # Create a new adjustment
  #
  #   POST /users/:user_permalink/buckets/:bucket_permalink/adjustments.html
  #   POST /users/:user_permalink/buckets/:bucket_permalink/adjustments.xml
  #   POST /users/:user_permalink/buckets/:bucket_permalink/adjustments.json
  def create
    if params[:adjustment] and params[:adjustment][:bucket_id]
      @bucket = Bucket.find(params[:adjustment][:bucket_id])
    end
    @adjustment = Adjustment.new
    @adjustment.user = @user
    @adjustment.bucket = @bucket
    if params[:adjustment] and @adjustment.update_attributes(params[:adjustment])
      flash[:success] = "Karma was successfully adjusted"
      respond_to do |format|
        format.html{ redirect_to adjustments_path(@user, @bucket) }
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
  #   GET /users/:user_permalink/buckets/:bucket_permalink/adjustments/:id.xml
  #   GET /users/:user_permalink/buckets/:bucket_permalink/adjustments/:id.json
  def show
    @adjustment = Adjustment.find params[:id]
    respond_to do |format|
      format.json { render :json => adjustment_to_json(@adjustment) }
      format.xml {  render :xml  => adjustment_to_xml(@adjustment)  }
    end
  end
  
  # Delete a particular bucket from the database.
  #
  #   DELETE /users/:user_permalink/buckets/:bucket_permalink/adjustments/:id.html
  #   DELETE /users/:user_permalink/buckets/:bucket_permalink/adjustments/:id.xml
  #   DELETE /users/:user_permalink/buckets/:bucket_permalink/adjustments/:id.json
  def destroy
    @adjustment = Adjustment.find params[:id]
    if @adjustment.destroy
      flash[:success] = "Adjustment was successfully destroyed."
    end
    respond_to do |format|
      format.json { render :json => adjustment_to_json(@adjustment) }
      format.xml  { render :xml  => adjustment_to_xml(@adjustment) }
    end    
  end

  private
  
  def find_user_and_bucket
    @user = User.find_by_permalink!(params[:user_permalink])
    @bucket = Bucket.find_by_permalink(params[:bucket_permalink])
  end

end