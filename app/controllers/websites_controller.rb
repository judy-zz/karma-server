class WebsitesController < ApplicationController
  
  def index
    @websites = Website.all
  end

  def show
    @website = Website.find(params[:id])
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
    @admins  = Admin.all
  end

  def update
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
  
end
