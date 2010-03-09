require 'faker'
require 'machinist'
require "machinist/active_record"

Sham.permalink { Faker::Name.name.gsub(/[^\w]+/, '-') }
Sham.url { "http://" + Faker::Internet.domain_name }
Sham.name { Faker::Name.name }

Bucket.blueprint do
  permalink
end

Admin.blueprint do
  name
end

Website.blueprint do
  name
  url
end

User.blueprint do
  permalink
end

Adjustment.blueprint do
  user   { User.make }
  bucket { Bucket.make }
  value  { (-10..10).collect.rand }
end

Website.blueprint do
  url  { 'http://' + Faker::Internet.domain_name }
  name { Faker::Company.catch_phrase }
end

Client.blueprint do
  website
  hostname   { Faker::Internet.domain_name }
  ip_address { (1..4).collect { rand(255) }.join('.') }
  api_key    { ActiveSupport::SecureRandom.hex(16) }
end

AdminsWebsites.blueprint do
  admin
  website
end