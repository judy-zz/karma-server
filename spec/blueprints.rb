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
