# A Client is a web server that serves a Website. This represents the machines
# that exchange data with the Karma server.
class Client < ActiveRecord::Base
  belongs_to :website
  
  HUMANIZED_ATTRIBUTES = {
    :ip_address => "IP Address"
  }
  
  before_validation_on_create :generate_api_key
  
  validates_presence_of   :hostname 
  validates_presence_of   :ip_address
  validates_presence_of   :api_key
  validates_uniqueness_of :hostname   
  validate                :valid_ip_address

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  private
  
  # we want to generate an api key for the client
  def generate_api_key
    self.api_key = ActiveSupport::SecureRandom.hex(16)
  end
  
  # we want the ip address to be formatted properly
  def valid_ip_address
    if ip_address
      address_bytes = ip_address.split('.')
      
      if address_bytes.detect { |b| b.to_i < 0 || b.to_i > 255 } || address_bytes.size != 4
        self.errors.add(:ip_address, "is not valid")
      end
    end
  end

end

# == Schema Information
#
# Table name: clients
#
#  id         :integer         not null, primary key
#  hostname   :string(255)
#  ip_address :string(255)
#  api_key    :string(255)
#  website_id :integer
#  created_at :datetime
#  updated_at :datetime
#

