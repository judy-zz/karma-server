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
  
  def client_permissions
    ActiveRecord::Base.transaction do
      ClientsWebsite.destroy_all
      # Here's what we're expecting in the params:
      #   'client_permissions' => {
      #     13 => [7, 8]      # a website id that points to an array of client ids
      #     14 => [5, 8]      # a website id that points to an array of client ids
      #   }
      #
      if params[:client_permissions] && params[:client_permissions].respond_to?(:each)
        params[:client_permissions].each do |website_id, client_ids|
          @website = Website.find(website_id)
          client_ids.each do |client_id|
            @client = Client.find(client_id)
            if @website && @client
              @website.clients << @client
            end
          end
        end
      end    
    end
    flash[:success] = "Permissions saved."
    redirect_to :back
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
