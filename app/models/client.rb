# A Client is a web server that serves a Website. This represents the machines
# that exchange data with the Karma server.
class Client < ActiveRecord::Base
  belongs_to :website
end
