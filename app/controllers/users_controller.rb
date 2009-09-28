class UsersController < ApplicationController

  include UsersHelper

  # List all users.
  #
  #   GET /users.html
  #   GET /users.json
  #   GET /users.xml
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render :json => @users }
      format.xml  { render :xml  => @users }
    end
  end
  
  # Display the template for creating a new user.
  #
  #   GET /users/new.html
  #   GET /users/new.json
  #   GET /users/new.xml
  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.json { render :json => @user }
      format.xml  { render :xml  => @user }
    end
  end
  
  # Create a new user (HTML format only).
  #
  #   POST /users.html
  #
  # Ideally, users are only created via PUT to /users/:permalink. 
  # We support POST to /users so that users can be created via HTML forms
  # (since those forms can't PUT to a permalink that's a form field).
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "User was successfully created."
      redirect_to @user
    else
      flash[:failure] = "User could not be created."
      render :action => :new
    end    
  end
  
  # Show a particular user.
  #
  #   GET /users/:permalink.html
  #   GET /users/:permalink.json
  #   GET /users/:permalink.xml
  def show
    @user = User.find_by_permalink!(params[:id])
    @buckets = Bucket.all
    respond_to do |format|
      format.html
      format.json { render :json => @user }
      format.xml  { render :xml  => @user }
    end    
  end
  
  # Show the karma summary for a user and the user's buckets
  #
  #   GET /users/:permalink/karma.json
  def karma
    @user = User.find_by_permalink!(params[:id])
    respond_to do |format|
      format.json { render :json => karma_for(@user) }
    end
  end
  
  # Display the template for editing an existing user.
  #
  #   GET /users/:permalink/edit.html
  #   GET /users/:permalink/edit.json
  #   GET /users/:permalink/edit.xml
  def edit
    @user = User.find_by_permalink!(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @user }
      format.xml  { render :xml  => @user }
    end
  end
  
  # Create or update a particular user.
  #
  #   PUT /users/:permalink.html
  #   PUT /users/:permalink.json
  #   PUT /users/:permalink.xml
  #
  # If the user does not already exist, it will be created at the given URI.
  # If the user already exists, it will be updated. If the permalink is 
  # updated, the URI of the resource will have changed, and a Location: header
  # will be returned with the location of the new resource.
  def update
    @user = User.find_or_initialize_by_permalink(params[:id])
    @user.attributes = params[:user]
    new_record = @user.new_record?
    permalink_changed = @user.changed.include?('permalink') && !new_record
    success = @user.save
    respond_to do |format|
      format.html do
        if success
          saved = new_record ? 'created' : 'updated'
          flash[:success] = "User was successfully #{saved}."
          redirect_to @user
        else
          render :action => :new
        end
      end
      format.json do
        if success
          if new_record
            render :json => @user, :status => :created
          else
            render :json => @user, :status => :ok
            if permalink_changed
              headers['Location'] = user_path(@user)
            end
          end
        else
          render :json => @user.errors, :status => :unprocessable_entity
        end
      end
      format.xml do
        if success
          if new_record
            render :xml => @user, :status => :created
          else
            render :xml => @user, :status => :ok
            if permalink_changed
              headers['Location'] = user_path(@user)
            end
          end
        else
          render :xml => @user.errors, :status => :unprocessable_entity
        end
      end
    end
  end
  
  # Delete a particular user from the database.
  #
  #   DELETE /users/:permalink
  #   DELETE /users/:permalink.json
  #   DELETE /users/:permalink.xml
  def destroy
    @user = User.find_by_permalink!(params[:id])
    if @user.destroy
      flash[:success] = "User was successfully destroyed."
    else
      flash[:failure] = "User could not be destroyed."
    end
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { render :json => @user }
      format.xml  { render :xml  => @user }
    end    
  end
    
end
