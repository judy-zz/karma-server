require 'faker'
require 'machinist'
require "machinist/active_record"

Sham.permalink { Faker::Name.name.gsub(/[^\w]+/, '-') }

Bucket.blueprint do
  permalink { Sham.permalink }
end

Admin.blueprint do
  name { Sham.name }
end

User.blueprint do
  permalink { Sham.permalink }
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