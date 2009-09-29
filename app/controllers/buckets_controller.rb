class BucketsController < ApplicationController
  
  # List all buckets.
  #
  #   GET /buckets.html
  #   GET /buckets.json
  #   GET /buckets.xml
  def index
    @buckets = Bucket.all
    respond_to do |format|
      format.html
      format.json{  render :json => @buckets  }
      format.xml{   render :xml => @buckets   }
    end
  end
  
  # Display the template for creating a new bucket.
  #
  #   GET /buckets/new.html
  #   GET /buckets/new.json
  #   GET /buckets/new.xml
  def new
    @bucket = Bucket.new
    respond_to do |format|
      format.html
      format.json{ render :json => @bucket } 
      format.xml { render :xml  => @bucket } 
    end
  end
  
  # Create a new bucket (HTML format only).
  #
  #   POST /bucket.html
  #
  # Ideally, buckets are only created via PUT to /buckets/:permalink. 
  # We support POST to /buckets so that buckets can be created via HTML forms
  # (since those forms can't PUT to a permalink that's a form field).
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
  
  # Show a particular user.
  #
  #   GET /users/:permalink.html
  #   GET /users/:permalink.json
  #   GET /users/:permalink.xml
  def show
    @bucket = Bucket.find_by_permalink! params[:id]
    respond_to do |format|
      format.html
      format.json{ render :json => @bucket }
      format.xml{  render :xml  => @bucket }
    end
  end
  
  # Display the template for editing an existing user.
  #
  #   GET /users/:permalink/edit.html
  #   GET /users/:permalink/edit.json
  #   GET /users/:permalink/edit.xml
  def edit
    @bucket = Bucket.find_by_permalink params[:id]
  end
  
  # Create or update a particular bucket.
  #
  #   PUT /buckets/:permalink.html
  #   PUT /buckets/:permalink.json
  #   PUT /buckets/:permalink.xml
  #
  # If the bucket does not already exist, it will be created at the given URI.
  # If the bucket already exists, it will be updated. If the permalink is 
  # updated, the URI of the resource will have changed, and a Location: header
  # will be returned with the location of the new resource.
  def update
    @bucket = Bucket.find_or_initialize_by_permalink(params[:id])
    @bucket.attributes = params[:bucket]
    new_record = @bucket.new_record?
    permalink_changed = @bucket.changed.include?('permalink') && !new_record
    success = @bucket.save
    respond_to do |format|
      format.html do
        if success
          saved = new_record ? 'created' : 'updated'
          flash[:success] = "Bucket was successfully #{saved}."
          redirect_to @bucket
        else
          render :action => :new
        end
      end
      format.json do
        if success
          if new_record
            render :json => @bucket, :status => :created
          else
            render :json => @bucket, :status => :ok
            if permalink_changed
              headers['Location'] = bucket_path(@bucket)
            end
          end
        else
          render :json => @bucket.errors, :status => :unprocessable_entity
        end
      end
      format.xml do
        if success
          if new_record
            render :xml => @bucket, :status => :created
          else
            render :xml => @bucket, :status => :ok
            if permalink_changed
              headers['Location'] = bucket_path(@bucket)
            end
          end
        else
          render :xml => @bucket.errors, :status => :unprocessable_entity
        end
      end
    end
  end
  
  # Delete a particular bucket from the database.
  #
  #   DELETE /buckets/:permalink.html
  #   DELETE /buckets/:permalink.json
  #   DELETE /buckets/:permalink.xml
  def destroy
    @bucket = Bucket.find_by_permalink!(params[:id])
    if @bucket.destroy
      flash[:success] = "Bucket was successfully destroyed."
    else
      flash[:failure] = "Bucket could not be destroyed."
    end
    respond_to do |format|
      format.html { redirect_to buckets_path }
      format.json { render :json => @bucket }
      format.xml  { render :xml  => @bucket }
    end    
  end
  
end