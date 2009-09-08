class BucketsController < ApplicationController
  
  def index
    @buckets = Bucket.all
    respond_to do |format|
      format.html
      format.json{  render :json => @buckets  }
      format.xml{   render :xml => @buckets   }
    end
  end
  
  def show
    @bucket = Bucket.find_by_name params[:id]
  end
  
  def edit
    @bucket = Bucket.find_by_name params[:id]
  end
  
  def update
    @bucket = Bucket.find_by_name params[:id]
    if @bucket.update_attributes(params[:bucket])
      flash[:success] = "Bucket was successfully updated."
      redirect_to @bucket
    else
      render :action => :edit
    end
  end
  
  def new
    @bucket = Bucket.new
  end
  
  def create
    @bucket = Bucket.new params[:bucket]
    if @bucket.save
      flash[:success] = "Bucket was successfully created."
      redirect_to @bucket
    else
      render :action => :new
    end
  end
  
  def destroy
    @bucket = Bucket.find_by_name params[:id]
    if @bucket.destroy
      flash[:success] = "Bucket was successfully deleted."
    else
      flash[:failure] = "Bucket could not be deleted."
    end
    redirect_to buckets_path
  end
  
end