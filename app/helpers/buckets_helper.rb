module BucketsHelper
  
  def bucket_to_hash(bucket, format = nil)
    bucket_hash = {
      'permalink' => bucket.permalink,
      'path' => (bucket.permalink ? bucket_path(bucket, :format => format) : nil),
      'created_at' => bucket.created_at,
      'updated_at' => bucket.updated_at
    }
    format == :json ? { :bucket => bucket_hash } : bucket_hash
  end
  
  def buckets_to_hash(buckets, format = nil)
    buckets.collect{|b| bucket_to_hash(b, format) }
  end
  
  def buckets_to_xml(buckets)
    buckets_to_hash(buckets, :xml).to_xml(:root => 'buckets')
  end
  
  def buckets_to_json(buckets)
    buckets_to_hash(buckets, :json).to_json(:root => 'buckets')
  end
  
  def bucket_to_xml(bucket)
    bucket_to_hash(bucket, :xml).to_xml(:root => 'bucket')
  end
  
  def bucket_to_json(bucket)
    bucket_to_hash(bucket, :json).to_json(:root => 'bucket')
  end
  
end
