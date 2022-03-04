# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require "open-uri"
require "nokogiri"
# require "pry"

LOCATIONS = ["Hyde Park", "Regents Park", "Primrose Hill", "Richmond Park", "Victoria Park"]
ACTIVITIES = %w[climbing tennis fencing]
TIMES = []
User.destroy_all
PairingSession.destroy_all

  5.times do
    puts "making user"
    user = User.new(
      email: Faker::Internet.email,
      password: "123456",
      address: Faker::Address.street_address,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      gender: Faker::Gender.binary_type,
      bio: Faker::Twitter.status,
      birth_date: Faker::Date.birthday(min_age: 18, max_age: 65),
      competitiveness: Faker::Number.within(range: 1..10)
    )
  user.save!
end

i = 0
  5.times do
    pairing_session = PairingSession.new(
      activity: ACTIVITIES.sample,
      address: LOCATIONS[i],
      description: Faker::Twitter.status[:text],
      time: [0, 15, 30, 45, 60].sample,
      user_id: User.all.sample.id
    )
  i = i +1
pairing_session.save!
end
