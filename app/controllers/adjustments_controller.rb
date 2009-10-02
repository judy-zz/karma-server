class AdjustmentsController < ApplicationController
  include AdjustmentsHelper
  before_filter :find_user

  # List all adjustments.
  #
  #   GET /users/:user_permalink/buckets/:bucket_permalink/adjustments.html
  #   GET /users/:user_permalink/buckets/:bucket_permalink/adjustments.xml
  #   GET /users/:user_permalink/buckets/:bucket_permalink/adjustments.json
  def index
    if (params[:bucket_permalink])
      @bucket = Bucket.find_by_permalink!(params[:bucket_permalink])
      @adjustments = @user.adjustments.find(:conditions => {:bucket_id => @bucket.id})
    else
      @adjustments = @user.adjustments
    end
    respond_to do |format|
      format.html
      format.json { render :json  => adjustments_to_json(@adjustments) }
      format.xml  { render :xml   => adjustments_to_xml(@adjustments) }
    end
  end
  
  # Display the template for creating a new adjustment.
  #
  #   GET /users/:user_permalink/buckets/:bucket_permalink/adjustments/new.html
  #   GET /users/:user_permalink/buckets/:bucket_permalink/adjustments/new.xml
  #   GET /users/:user_permalink/buckets/:bucket_permalink/adjustments/new.json
  def new
    @bucket = Bucket.find_by_permalink!(params[:bucket_permalink])
    @adjustment = Adjustment.new(:user => @user, :bucket => @bucket)
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
    # Harvest the bucket from the form, if we were called that way. 
    if params[:adjustment] && params[:adjustment][:bucket_id]
      @bucket = Bucket.find(params[:adjustment][:bucket_id])
    else
      @bucket = Bucket.find_by_permalink!(params[:bucket_permalink])
    end
    @adjustment = Adjustment.new(:user => @user, :bucket => @bucket)
    if params[:adjustment] && @adjustment.update_attributes(params[:adjustment])
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
  
  # Show a particular adjustment.
  #
  #   GET /users/:user_permalink/buckets/:bucket_permalink/adjustments/:id.xml
  #   GET /users/:user_permalink/buckets/:bucket_permalink/adjustments/:id.json
  def show
    @bucket = Bucket.find_by_permalink!(params[:bucket_permalink])
    @adjustment = Adjustment.find(params[:id])
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
    @bucket = Bucket.find_by_permalink!(params[:bucket_permalink])
    @adjustment = @user.adjustments.find(:first, :conditions => {
      :id => params[:id],
      :bucket_id => @bucket.id
    })
    if @adjustment.destroy
      flash[:success] = "Adjustment was successfully destroyed."
    end
    respond_to do |format|
      format.json { render :json => adjustment_to_json(@adjustment) }
      format.xml  { render :xml  => adjustment_to_xml(@adjustment) }
    end    
  end

  private
  
  def find_user
    @user = User.find_by_permalink!(params[:user_permalink])
  end

end