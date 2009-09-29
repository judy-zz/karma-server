module AdjustmentsHelper
  def new_adjustment_url
    @bucket ? adjustments_path(@user, @bucket) : user_adjustments_path(@user)
  end
  
  def subtitle
    if @user && @bucket
      "#{@user.permalink}: #{@bucket.permalink}"
    elsif @user
      @user.permalink
    elsif @bucket
      @bucket.permalink
    else
      ""
    end
  end
end
