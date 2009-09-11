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
    @adjustment.bucket = @bucket
    if @adjustment.update_attributes(params[:adjustment])
      redirect_to user_bucket_adjustments_path(@user, @bucket)
    else
      render :new
    end      
  end

  def index
    @adjustments = Adjustment.find(:all, :conditions => {:user_id => @user.id, :bucket_id => @bucket.id})
    respond_to do |format|
      format.html
      format.xml { render :xml => @adjustments.to_xml }
    end
  end

  private
  
  def find_user_and_bucket
    @user = User.find_by_permalink!(params[:user_permalink])
    @bucket = Bucket.find_by_name!(params[:bucket_permalink])
  end

end
