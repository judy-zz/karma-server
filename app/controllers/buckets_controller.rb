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
  # GET /buckets/Animals.json
  def show
    @bucket = Bucket.find_by_permalink params[:id]
    if @bucket
      respond_to do |format|
        format.html
        format.json{ render :json => @bucket }
      end
    else
      respond_to do |format|
        format.html{ render :html => '', :status => 500 }
        format.json{ render :json => '', :status => 500 }
      end
    end
  end
  
  # GET /buckets/Animals/edit
  def edit
    @bucket = Bucket.find_by_permalink params[:id]
  end
  
  # GET /buckets/new
  # GET /buckets/new.json
  def new
    @bucket = Bucket.new
    respond_to do |format|
      format.html
      format.json{ render :json => @bucket } 
    end
  end
  
  # PUT /buckets/Animals
  # PUT /buckets/Animals.json
  #
  # Used for creating and updating buckets
  # view the features located at /features/buckets.*.feature
  # for details on the design of this method.
  def update
    @bucket = Bucket.find_or_new_by_permalink params[:id]
    if @bucket.new_record?
      if @bucket.save
        respond_to do |format|
          format.html do
            flash[:success] = "Bucket was successfully created."
            redirect_to @bucket
          end
          format.json{ render :json => '', :status => 201 }
        end
      else
        respond_to do |format|
          format.html{ render :action => :new }
          format.json{ render :json => '', :status => 500 }
        end
      end
    else
      if @bucket.update_attributes(params[:bucket])
        respond_to do |format|
          format.html do
            flash[:success] = "Bucket was successfully updated."
            redirect_to @bucket
          end
          format.json{ render :json => @bucket, :status => 200 }
        end
      else
        respond_to do |format|
          format.html{ render :action => :edit }
          format.json{ render :json => '', :status => 500 }
        end
      end
    end
  end
  
  # POST /buckets
  def create
    @bucket = Bucket.new params[:bucket]
    if @bucket.save
      flash[:success] = "Bucket was successfully created."
      redirect_to @bucket
    else
      flash[:failure] = "Bucket could not be created."
      render :action => :new
    end
  end
  
  # DELETE /buckets/Animals
  # DELETE /buckets/Animals.json
  def destroy
    @bucket = Bucket.find_by_permalink params[:id]
    if @bucket.destroy
      flash[:success] = "Bucket was successfully destroyed."
    else
      flash[:failure] = "Bucket could not be destroyed."
    end
    redirect_to buckets_path
  end
  
end