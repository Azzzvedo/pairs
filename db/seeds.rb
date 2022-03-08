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
ACTIVITIES = %w[climbing tennis pool squash golf running badminton cycling swimming]
TIMES = []
User.destroy_all
PairingSession.destroy_all

users = ['arabella.stephenson@gmail.com', 'ian.wiggins@gmail.com', 'josh.walker@gmail.com', 'luz.valdovinos@gmail.com']
users.each do |user|
  name = user.split("@")[0].split(".")
  admin = User.create(
    first_name: name[0].capitalize,
    last_name: name[1].capitalize,
    email: user,
    password: "123456",
    address: Faker::Address.street_address,
    gender: Faker::Gender.binary_type,
    bio: Faker::Twitter.status[:text],
    birth_date: Faker::Date.birthday(min_age: 18, max_age: 65),
    competitiveness: Faker::Number.within(range: 1..10)
  )
  i = 0
  5.times do
    pairing_session = PairingSession.new(
      activity: ACTIVITIES.sample,
      address: LOCATIONS[i],
      description: Faker::Twitter.status[:text],
      time: [0, 15, 30, 45, 60].sample,
      datetime: Faker::Date.between(from: '2022-03-11', to: '2022-03-25'),
      user_id: admin.id
    )
    i += 1
    pairing_session.save!
  end
end

5.times do
  user = User.new(
    email: Faker::Internet.email,
    password: "123456",
    address: Faker::Address.street_address,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    gender: Faker::Gender.binary_type,
    bio: Faker::Twitter.status[:text],
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
    user_id: User.all.sample.id,
    datetime: Faker::Date.between(from: '2022-03-11', to: '2022-03-25')
  )
  i += 1
  pairing_session.save!
end
