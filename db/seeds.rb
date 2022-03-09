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

LOCATIONS = ["Hyde Park, London", "Regents Park, London", "Primrose Hill, London", "Richmond Park, London", "Victoria Park, London"]
ACTIVITIES = %w[climbing tennis golf running badminton cycling swimming]
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
      datetime: Faker::Time.between_dates(from: Date.today, to: Date.today + 1, period: :day),
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
    datetime: Faker::Time.between_dates(from: Date.today, to: Date.today + 1, period: :day)
  )
  i += 1
  pairing_session.save!
end

mcenroe = User.new(
  email: 'john.mcenroe@gmail.com',
  password: '123456',
  address: 'New York',
  first_name: 'John',
  last_name: 'McEnroe',
  gender: 'Male',
  bio: 'You cannot be serious!',
  birth_date: '1959-02-16',
  competitiveness: 10
)
john_photo = URI.open('https://cdn.cnn.com/cnnnext/dam/assets/130214142218-mcenroe-angry.jpg')
mcenroe.photo.attach(io: john_photo, filename: 'john_photo.jpg', content_type: 'image/jpg')
mcenroe.save!

john_tennis_session = PairingSession.new(
  activity: 'tennis',
  address: 'Wimbledon',
  description: 'Lovely casual game of tennis between friends',
  time: [0, 15, 30, 45, 60].sample,
  user_id: mcenroe.id,
  datetime: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :evening)
)
john_tennis_session.save!

novak = User.new(
  email: 'novak.djokovic@gmail.com',
  password: '123456',
  address: 'New York',
  first_name: 'Novak',
  last_name: 'Djokovic',
  gender: 'Male',
  bio: '20 time Grand-Slam Winner',
  birth_date: '1987-05-22',
  competitiveness: 8
)
novak_photo = URI.open('https://cdn-japantimes.com/wp-content/uploads/2022/02/np_file_142642.jpeg')
novak.photo.attach(io: novak_photo, filename: 'novak_photo.jpg', content_type: 'image/jpg')
novak.save!

novak_tennis_session = PairingSession.new(
  activity: 'tennis',
  address: 'Wimbledon',
  description: 'Could really do with a game..!',
  time: [0, 15, 30, 45, 60].sample,
  user_id: novak.id,
  datetime: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :evening)
)
novak_tennis_session.save!

ian = User.find_by(email: 'ian.wiggins@gmail.com')
ian_tennis_session = PairingSession.new(
  activity: 'tennis',
  address: 'Wimbledon',
  description: 'Hey! Looking for a casual tennis sesh if anyone fancies a game?',
  time: [0, 15, 30, 45, 60].sample,
  user_id: ian.id,
  datetime: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :evening)
)
ian_tennis_session.save!
