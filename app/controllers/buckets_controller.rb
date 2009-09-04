class BucketsController < InheritedResources::Base
  respond_to :html, :xml, :json
  
  def index
    @buckets = Bucket.all :conditions => { :deleted_at => nil }
    respond_to do |format|
      format.html
      format.json{ render :json => @buckets }
    end
  end
  
  def deleted
    @buckets = Bucket.deleted
  end
  
  def restore
    @bucket = Bucket.find params[:id]
    @bucket.deleted_at = nil
    if @bucket.save
      flash[:notice] = "Bucket was successfully restored."
    else
      flash[:notice] = "Bucket could not be restored."
    end
    redirect_to :action => :deleted
  end
  
end