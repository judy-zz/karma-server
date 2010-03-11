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
  end

  def update
    authorize = false
    @admin = Admin.find(params[:id])
    @admin.attributes = params[:admin]
    if @admin.changes["super_admin"].nil? && @admin == current_admin
      authorized = true
    elsif @admin.changes.size < 2 && @admin.changes["super_admin"] && current_admin.super_admin == true
      authorized = true
    end
    
    if @admin.changes.size == 0
      flash[:success] = "No changes were made to this admin."
      redirect_to @admin
    elsif authorized
      if @admin.save
        flash[:success] = "Admin was successfully saved."
        redirect_to @admin
      else
        flash[:failure] = "Admin couldn't be saved."
        render :action => "edit"
      end
    else
      flash[:failure] = "You must have sufficient privileges"
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
