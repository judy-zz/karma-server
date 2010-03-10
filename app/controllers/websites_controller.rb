class WebsitesController < ApplicationController
  before_filter :get_all_admins
  
  def index
    @websites = Website.all
  end

  def show
    @website = Website.find(params[:id])
  end
  
  def administrators
    @websites = Website.all
  end
  
  def permissions
    ActiveRecord::Base.transaction do
      AdminsWebsite.destroy_all
      params[:permissions].each do |website_set|
        @website = Website.find(website_set[0].to_i)
        website_set[1].each do |admin_id|
          @admin = Admin.find(admin_id.to_i)
          if @website && @admin
            @website.admins << @admin
          end
        end
      end
    end    
      flash[:success] = "Permissions saved."
    rescue
      flash[:failure] = "Permissions did not save."
    ensure
      redirect_to :back
  end
  
  def clients
    @websites = Website.all
  end

  def new
    @website = Website.new
  end

  def create
    @website = Website.new(params[:website])
    if @website.save
      flash[:success] = "Website was successfully created."
      redirect_to @website
    else
      flash[:failure] = "Website couldn't be created."
      render :action => "new"
    end
  end

  def edit
    @website = Website.find(params[:id])
  end

  def update
    params[:website][:admin_ids] ||= []
    @website = Website.find(params[:id])
    if @website.update_attributes(params[:website])
      flash[:success] = "Website was successfully saved."
      redirect_to @website
    else
      flash[:failure] = "Website couldn't be saved."
      render :action => "edit"
    end
  end

  def destroy
    @website = Website.find(params[:id])
    @website.destroy
    flash[:success] = "Website was successfully destroyed."
    redirect_to websites_path
  end
  
  private
  
  def get_all_admins
    @all_admins = Admin.all
  end
  
end
