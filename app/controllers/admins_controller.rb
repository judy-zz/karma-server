class AdminsController < ApplicationController
  
  def index
    @admins = Admin.all
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      flash[:success] = "Admin was successfully created."
      redirect_to @admin
    else
      flash[:failure] = "Admin couldn't be created."
      render :action => "new"
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update_attributes(params[:admin])
      flash[:success] = "Admin was successfully saved."
      redirect_to @admin
    else
      flash[:failure] = "Admin couldn't be saved."
      render :action => "edit"
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    flash[:success] = "Admin was successfully destroyed."
    redirect_to admins_path
  end
  
end
