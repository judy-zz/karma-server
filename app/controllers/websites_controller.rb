class WebsitesController < ApplicationController
  before_filter :get_all_admins     , :except => [:index, :destroy]
  before_filter :get_all_clients    , :except => [:index, :destroy]
  
  def index
    @websites = Website.all
  end

  def show
    @website = Website.find(params[:id])
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
    params[:website][:client_ids] ||= []
    if @website = Website.find(params[:id])

      if @website.update_attributes(params[:website])
        flash[:success] = "Website was successfully saved."
        redirect_to @website
      else
        flash[:failure] = "Website couldn't be saved."
        render :action => "edit"
      end

    else 
      flash[:failure] = "Cound not find the website."
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
    @all_admins  = Admin.all
  end
  
  def get_all_clients
    @all_clients = Client.all
  end
  
end
