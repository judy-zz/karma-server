class BucketsController < ApplicationController
  
  def index
    @buckets = Bucket.find :all
    
    respond_to do |format|
      format.html
      format.json { render :json => @buckets }
    end 
  end
  
end