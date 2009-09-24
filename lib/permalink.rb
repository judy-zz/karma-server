module ActiveRecord
  module Validations
    module ClassMethods
      def validates_as_email(*attr_names)
        configuration = {
          :message   => 'is an invalid email',
          :with      => RFC822::EmailAddress,
          :allow_nil => true }
        configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)
 
        validates_format_of attr_names, configuration
      end
    end
  end
end

def url_encodable?(link)
  link == CGI::unescape(CGI::escape(link))
end