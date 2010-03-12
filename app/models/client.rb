# A Client is a web server that serves a Website. This represents the machines
# that exchange data with the Karma server.
class Client < ActiveRecord::Base
  
  HUMANIZED_ATTRIBUTES = {
    :ip_address => "IP Address"
  }
  
  has_many :clients_websites
  has_many :websites, :through => :clients_websites, :uniq => true
  
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
    return if self.ip_address.blank?
    raise ArgumentError if ! self.ip_address.respond_to?(:split)
    bytes = self.ip_address.split('.')
    raise ArgumentError if bytes.length != 4
    raise ArgumentError if bytes.detect { |b| Integer(b) < 0 || Integer(b) > 254 }
  rescue ArgumentError
    self.errors.add(:ip_address, "is not valid")
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

