class ClientsController < ApplicationController
  
  def index
    @clients = Client.all
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      flash[:success] = "Client was successfully created."
      redirect_to @client
    else
      flash[:failure] = "Client couldn't be created."
      render :action => "new"
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(params[:client])
      flash[:success] = "Client was successfully saved."
      redirect_to @client
    else
      flash[:failure] = "Client couldn't be saved."
      render :action => "edit"
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    flash[:success] = "Client was successfully destroyed."
    redirect_to clients_path
  end
  
end