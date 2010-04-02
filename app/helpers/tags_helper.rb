module TagsHelper
  
  def tag_to_hash(tag, format = nil)
    tag_hash = {
      'permalink' => tag.permalink,
      'path' => (tag.permalink.blank? ? nil : tag_path(tag, :format => format)),
      'created_at' => tag.created_at,
      'updated_at' => tag.updated_at
    }
    format == :json ? { :tag => tag_hash } : tag_hash
  end
  
  def tags_to_hash(tags, format = nil)
    tags.collect{|b| tag_to_hash(b, format) }
  end
  
  def tags_to_xml(tags)
    tags_to_hash(tags, :xml).to_xml(:root => 'tags')
  end
  
  def tags_to_json(tags)
    tags_to_hash(tags, :json).to_json(:root => 'tags')
  end
  
  def tag_to_xml(tag)
    tag_to_hash(tag, :xml).to_xml(:root => 'tag')
  end
  
  def tag_to_json(tag)
    tag_to_hash(tag, :json).to_json(:root => 'tag')
  end
  
end
