class AdjustmentsController < ApplicationController

  before_filter :find_user_and_bucket

  def new
    @adjustment = Adjustment.new
    @adjustment.user = @user
    @adjustment.bucket = @bucket
  end

  def create
    @adjustment = Adjustment.new
    @adjustment.user = @user
    if params[:adjustment][:bucket_id]
      @bucket = Bucket.find(params[:adjustment][:bucket_id])
    end
    @adjustment.bucket = @bucket
    if @adjustment.update_attributes(params[:adjustment])
      flash[:success] = "Karma was successfully adjusted"
      redirect_to adjustments_path(@user, @bucket)
    else
      flash[:failure] = "Karma failed to be adjusted"
      render :new
    end      
  end

  def index
    @adjustments = Adjustment.find(:all, :conditions => {:user_id => @user.id, :bucket_id => @bucket.id})
    respond_to do |format|
      format.html
      format.xml  { render :xml  => @adjustments }
      format.json { render :json => @adjustments }
    end
  end

  private
  
  def find_user_and_bucket
    @user = User.find_by_permalink!(params[:user_permalink])
    @bucket = Bucket.find_by_permalink(params[:bucket_permalink])
  end

end
