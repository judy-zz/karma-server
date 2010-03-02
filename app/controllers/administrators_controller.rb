class AdministratoristratorsController < ApplicationController
  
  def index
    @admins = Administrator.all
  end

  def show
    @admin = Administrator.find(params[:id])
  end

  def new
    @admin = Administrator.new
  end

  def create
    @admin = Administrator.new(params[:admin])
    if @admin.save
      flash[:success] = "Admin was successfully created."
      redirect_to @admin
    else
      flash[:failure] = "Admin couldn't be created."
      render :action => "new"
    end
  end

  def edit
    @admin = Administrator.find(params[:id])
  end

  def update
    @admin = Administrator.find(params[:id])
    if @admin.update_attributes(params[:admin])
      flash[:success] = "Admin was successfully saved."
      redirect_to @admin
    else
      flash[:failure] = "Admin couldn't be saved."
      render :action => "edit"
    end
  end

  def destroy
    @admin = Administrator.find(params[:id])
    @admin.destroy
    flash[:success] = "Admin was successfully destroyed."
    redirect_to administrators_path
  end
  
end
