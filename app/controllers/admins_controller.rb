class AdminsController < ApplicationController
  before_filter :require_super_admin, :only => [:new, :create, :destroy]
  
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
    if current_admin.super_admin? || @admin == current_admin
      # show the profile
    else
      flash[:failure] = "You have insufficient privileges"
      redirect_to :back
    end
  end

  def update
    if @admin = Admin.find(params[:id])      
      if current_admin.super_admin? || @admin == current_admin
        @admin.attributes   = params[:admin]
        @admin.super_admin  = params[:admin][:super_admin] if current_admin.super_admin?
        if @admin.save
          flash[:success] = "Admin was successfully saved."
          redirect_to @admin
        else
          flash[:failure] = "Updating the admin failed."
          render :edit
        end
      else
        flash[:failure] = "You have insufficient privileges"
        redirect_to @admin
      end
    else
      flash[:failure] = "Could not find the admin."
      redirect_to @admin
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    flash[:success] = "#{@admin.name} was successfully destroyed."
    redirect_to admins_path
  end
  
end
