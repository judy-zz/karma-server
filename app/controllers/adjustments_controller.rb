class AdjustmentsController < ApplicationController

  before_filter :find_user_and_bucket

  def index
    @adjustments = Adjustment.find(:all, :conditions => {:user_id => @user.id, :bucket_id => @bucket.id})
    respond_to do |format|
      format.html
      format.xml  { render :xml   => @adjustments }
      format.json { render :json  => @adjustments }
    end
  end

  def new
    @adjustment = Adjustment.new :user => @user, :bucket => @bucket
    respond_to do |format|
      format.html
      format.xml{ render :xml => @adjustment }
    end
  end

  def create
    if params[:adjustment][:bucket_id]
      @bucket = Bucket.find(params[:adjustment][:bucket_id])
    end
    @adjustment = Adjustment.new
    @adjustment.user = @user
    @adjustment.bucket = @bucket
    if @adjustment.update_attributes(params[:adjustment])
      flash[:success] = "Karma was successfully adjusted"
      respond_to do |format|
        format.html{ redirect_to adjustments_path(@user, @bucket) }
        format.xml{  render :xml => @adjustment, :status => :created }
      end
    else
      flash[:failure] = "Karma failed to be adjusted"
      respond_to do |format|
        format.html{ render :new }
        format.xml{  render :xml => @adjustment.errors, :status => :unprocessable_entity }
      end
    end      
  end
  
  # Update an adjustment.
  #
  #   PUT /users/:user_permalink/buckets/:bucket_permalink/adjustments/:id.xml
  def update
    @adjustment = Adjustment.find params[:id]
    if params[:adjustment][:bucket_id]
      @adjustment.bucket_id = params[:adjustment][:bucket_id]
    end
    if params[:adjustment][:user_id]
      @adjustment.user_id = params[:adjustment][:user_id]
    end
    if @adjustment.save and @adjustment.update_attributes(params[:adjustment])
      respond_to do |format|
        format.xml { render :xml => @adjustment }
      end
    else
      respond_to do |format|
        format.xml { render :xml => @adjustment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    @adjustment = Adjustment.find params[:id]
    respond_to do |format|
      format.xml { render :xml => @adjustment }
    end
  end

  private
  
  def find_user_and_bucket
    @user = User.find_by_permalink!(params[:user_permalink])
    @bucket = Bucket.find_by_permalink(params[:bucket_permalink])
  end

end