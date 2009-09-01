require 'faker'
require 'machinist'
require "machinist/active_record"

User.blueprint do
  permalink { Faker::Name.name }
end
