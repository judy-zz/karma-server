module UsersHelper
  
  # Return a structured set of data that fully represents the karma for the
  # given user. This data structure is suitable for calling #to_json or
  # #to_xml.
  def karma_for(user, format = :json)
    # Assemble the stanza that describes the per-bucket karma
    buckets_karma = {}
    Bucket.all.each do |bucket|
      buckets_karma[bucket.permalink] = {
        :bucket_path => bucket_path(bucket, :format => format),
        :adjustments_path => adjustments_path(user, bucket, :format => format),
        :total => user.karma_for(bucket)
      }
    end
    # Assemble the stanza for user-level karma.
    karma = {
      :user => user.permalink,
      :user_path => user_path(user, :format => format),
      :total => user.karma,
      :buckets => buckets_karma
    }
    
    eval("karma.to_#{format}(:root => 'karma')")
  end

  # Create and return the hash with the fields used the JSON and XML API
  def user_to_hash(user, format = nil)
    user_hash =  {
      'permalink' => user.permalink,
      'path' => (user.permalink ? user_path(user, :format => format) : nil),
      'created_at' => user.created_at,
      'updated_at' => user.updated_at
    }
    format == :json ? { :user => user_hash } : user_hash
  end
  
  # Return the collection of users in a hash for the JSON and XML API
  # If the format is :json then enclose each user hash with a :user key.
  # otherwise simply return the collection without the key
  def users_to_hash(users, format = nil)
    users.collect{|b| user_to_hash(b, format) }
  end
  
  # Returns an array of User objects in XML format for use in the XML API
  def users_to_xml(users)
    users_to_hash(users, :xml).to_xml(:root => 'users')
  end
  
  # Returns an array of User objects in JSON format for use in the JSON API
  def users_to_json(users)
    users_to_hash(users, :json).to_json(:root => 'users')
  end
  
  # Returns a User object in XML format for use in the XML API
  def user_to_xml(user)
    user_to_hash(user, :xml).to_xml(:root => 'user')
  end
  
  # Returns a User object in JSON format for use in the JSON API
  def user_to_json(user)
    user_to_hash(user, :json).to_json(:root => 'user')
  end
  
end