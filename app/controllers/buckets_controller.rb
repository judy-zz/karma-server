class BucketsController < ApplicationController
  
  # GET /buckets
  # GET /buckets.json
  # GET /buckets.xml
  def index
    @buckets = Bucket.all
    respond_to do |format|
      format.html
      format.json{  render :json => @buckets  }
      format.xml{   render :xml => @buckets   }
    end
  end
  
  # GET /buckets/Animals
  def show
    @bucket = Bucket.find_by_name params[:id]
    respond_to do |format|
      format.html
      format.json{ render :json => @bucket }
    end
  end
  
  # GET /buckets/Animals/edit
  def edit
    @bucket = Bucket.find_by_name params[:id]
  end
  
  # PUT /buckets/Animals
  def update
    @bucket = Bucket.find_by_name params[:id]
    if @bucket.update_attributes(params[:bucket])
      flash[:success] = "Bucket was successfully updated."
      redirect_to @bucket
    else
      render :action => :edit
    end
  end
  
  # GET /buckets/new
  def new
    @bucket = Bucket.new
  end
  
  # POST /buckets
  def create
    @bucket = Bucket.new params[:bucket]
    if @bucket.save
      flash[:success] = "Bucket was successfully created."
      redirect_to @bucket
    else
      render :action => :new
    end
  end
  
  # DELETE /buckets/Animals
  def destroy
    @bucket = Bucket.find_by_name params[:id]
    if @bucket.destroy
      flash[:success] = "Bucket was successfully destroyed."
    else
      flash[:failure] = "Bucket could not be destroyed."
    end
    redirect_to buckets_path
  end
  
end