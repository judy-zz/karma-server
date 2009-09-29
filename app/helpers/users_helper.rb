module UsersHelper
  
  # Return a structured set of data that fully represents the karma for the
  # given user. This data structure is suitable for calling #to_json or
  # #to_xml.
  def karma_for(user)
    # Assemble the stanza that describes the per-bucket karma
    buckets_karma = {}
    Bucket.all.each do |bucket|
      buckets_karma[bucket.permalink] = {
        :bucket_path => bucket_path(bucket, :format => :json),
        :adjustments_path => adjustments_path(user, bucket, :format => :json),
        :total => user.karma_for(bucket)
      }
    end
    # Assemble the stanza for user-level karma.
    karma = {
      :user => user.permalink,
      :user_path => user_path(user, :format => :json),
      :total => user.karma,
      :buckets => buckets_karma
    }
  end
  
end
