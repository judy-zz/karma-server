class TagsController < ApplicationController

  include TagsHelper
  
  # List all tags.
  #
  #   GET /tags.html
  #   GET /tags.json
  #   GET /tags.xml
  def index
    if current_client
      @tags = Tag.by_website(current_client.website)
    else
      @tags = Tag.shared
    end
    
    respond_to do |format|
      format.html
      format.json{  render :json => tags_to_json(@tags)  }
      format.xml {  render :xml  => tags_to_xml(@tags)   }
    end
  end
  
  # Display the template for creating a new tag.
  #
  #   GET /tags/new.html
  #   GET /tags/new.json
  #   GET /tags/new.xml
  def new
    @tag = Tag.new
    respond_to do |format|
      format.html
      format.json{ render :json => tag_to_json(@tag) } 
      format.xml { render :xml  => tag_to_xml(@tag) } 
    end
  end
  
  # Create a new tag (HTML format only).
  #
  #   POST /tag.html
  #
  # Ideally, tags are only created via PUT to /tags/:permalink. 
  # We support POST to /tags so that tags can be created via HTML forms
  # (since those forms can't PUT to a permalink that's a form field).
  def create
    @tag = Tag.new params[:tag]
    @tag.website_id = params[:website_id] if params[:website_id]
    if @tag.save
      flash[:success] = "Tag was successfully created."
      if params[:website_id]
        redirect_to website_path(params[:website_id])
      else
        redirect_to @tag
      end
    else
      flash[:failure] = "Tag couldn't be created."
      if params[:website_id]
        redirect_to website_path(params[:website_id])
      else
        render :action => :new
      end
    end
  end
  
  # Show a particular tag.
  #
  #   GET /tags/:permalink.html
  #   GET /tags/:permalink.json
  #   GET /tags/:permalink.xml
  def show
    @tag = Tag.find_by_permalink! params[:id]
    respond_to do |format|
      format.html
      format.json{ render :json => tag_to_json(@tag) }
      format.xml{  render :xml  => tag_to_xml(@tag) }
    end
  end
  
  # Display the template for editing an existing tag.
  #
  #   GET /tags/:permalink/edit.html
  #   GET /tags/:permalink/edit.json
  #   GET /tags/:permalink/edit.xml
  def edit
    @tag = Tag.find_by_permalink params[:id]
  end
  
  # Create or update a particular tag.
  #
  #   PUT /tags/:permalink.html
  #   PUT /tags/:permalink.json
  #   PUT /tags/:permalink.xml
  #
  # If the tag does not already exist, it will be created at the given URI.
  # If the tag already exists, it will be updated. If the permalink is 
  # updated, the URI of the resource will have changed, and a Location: header
  # will be returned with the location of the new resource.
  def update
    
    unless @tag = Tag.find_by_permalink(params[:id])
      @tag = Tag.new(:permalink => params[:id])
    end
    
    @tag.attributes = params[:tag]
    new_record = @tag.new_record?
    saved = new_record ? "created" : "updated"
    permalink_changed = @tag.changed.include?('permalink') && !new_record
    success = @tag.save
    respond_to do |format|
      format.html do
        if success
          saved = new_record ? 'created' : 'updated'
          flash[:success] = "Tag was successfully #{saved}."
          if params[:website_id]
            redirect_to website_path(params[:website_id])
          else
            redirect_to @tag
          end
        else
          flash[:failure] = "Tag couldn't be #{saved}."
          if new_record
            render :action => :new
          else
            render :action => :edit
          end
        end
      end
      format.json do
        if success
          if new_record
            render :json => tag_to_json(@tag), :status => :created
          else
            render :json => tag_to_json(@tag), :status => :ok
            if permalink_changed
              headers['Location'] = tag_path(@tag)
            end
          end
        else
          render :json => @tag.errors, :status => :unprocessable_entity
        end
      end
      format.xml do
        if success
          if new_record
            render :xml => tag_to_xml(@tag), :status => :created
          else
            render :xml => tag_to_xml(@tag), :status => :ok
            if permalink_changed
              headers['Location'] = tag_path(@tag)
            end
          end
        else
          render :xml => @tag.errors, :status => :unprocessable_entity
        end
      end
    end
  end
  
  # Delete a particular tag from the database.
  #
  #   DELETE /tags/:permalink.html
  #   DELETE /tags/:permalink.json
  #   DELETE /tags/:permalink.xml
  def destroy
    @tag = Tag.find_by_permalink!(params[:id])
    @tag.destroy
    flash[:success] = "Tag was successfully destroyed."
    respond_to do |format|
      format.html { 
        if params[:website_id] 
          redirect_to website_path(params[:website_id])
        else
          redirect_to tags_path 
        end
      }
      format.json { render :json => tag_to_json(@tag) }
      format.xml  { render :xml  => tag_to_xml(@tag)  }
    end    
  end
  
end