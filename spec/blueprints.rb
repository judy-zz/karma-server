require 'faker'
require 'machinist'
require "machinist/active_record"

User.blueprint do
  token { Faker::Name.name }
end
