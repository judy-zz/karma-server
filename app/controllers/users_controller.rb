class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    respond_to do |format|
      format.html do
        @user = User.create!(params[:user])
        redirect_to user_path(@user)
      end
      format.json do
        if @user = User.find_by_permalink(params[:permalink])
          head :ok
        else
          @user = User.create!(:permalink => params[:permalink])
          head :created
        end
      end
    end
  end
  
  def show
    @user = User.find_by_permalink(params[:permalink])
    
    respond_to do |format|
      format.html
      format.json do
        if @user
          render :json => @user
        else
          head :not_found
        end          
      end
    end
    
  end
  
end