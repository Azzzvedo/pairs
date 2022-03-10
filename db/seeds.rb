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
john_photo = URI.open('https://static.standard.co.uk/s3fs-public/thumbnails/image/2012/06/19/11/JOHN-MCENROE.jpg?width=968')
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


emma = User.new(
  email: 'emma@gmail.com',
  password: '123456',
  address: 'London',
  first_name: 'Emma',
  last_name: 'Raducanu',
  gender: 'Female',
  bio: 'Starting to get pretty good at this tennis thing!',
  birth_date: '1943-11-22',
  competitiveness: 8
)
emma_photo = URI.open('https://i.guim.co.uk/img/media/28d257e19e00b118147fa19c8aea4ee99e5b762e/0_43_3500_2101/master/3500.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=95e14cf9583a5d69877a4946ba8c5846')
emma.photo.attach(io: emma_photo, filename: 'emma_photo.jpg', content_type: 'image/jpg')
emma.save!

emma_tennis_session = PairingSession.new(
  activity: 'tennis',
  address: 'Wimbledon',
  description: 'I want to get in a few practice games before a little competition I\'m taking part in this summer!',
  time: [0, 15, 30, 45, 60].sample,
  user_id: emma.id,
  datetime: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :evening)
)
emma_tennis_session.save!

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

ronnie = User.new(
  email: 'ronnie@gmail.com',
  password: '123456',
  address: 'Wordsley',
  first_name: 'Ronnie',
  last_name: 'O\'sullivan',
  gender: 'Male',
  bio: 'Total amateur! Let\'s say £10 a game. Rack \'em up!!',
  birth_date: '1975-12-5',
  competitiveness: 4
)
ronnie_photo = URI.open('https://i2-prod.mirror.co.uk/incoming/article22463150.ece/ALTERNATES/s1200c/0_The-Dafabet-Masters-Day-Five.jpg')
ronnie.photo.attach(io: ronnie_photo, filename: 'ronnie_photo.jpg', content_type: 'image/jpg')
ronnie.save!

billiejean = User.new(
  email: 'billiejean@gmail.com',
  password: '123456',
  address: 'California',
  first_name: 'Billie Jean',
  last_name: 'King',
  gender: 'Female',
  bio: 'Love schooling arrogant blokes on the court!',
  birth_date: '1943-11-22',
  competitiveness: 8
)
billiejean_photo = URI.open('https://www.history.com/.image/ar_16:9%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cg_faces:center%2Cq_auto:good%2Cw_768/MTgxNDc5MTg2Mjc0MTk5MzA2/gettyimages-657821811.jpg')
billiejean.photo.attach(io: billiejean_photo, filename: 'billiejean_photo.jpg', content_type: 'image/jpg')
billiejean.save!

billiejean_tennis_session = PairingSession.new(
  activity: 'tennis',
  address: 'Wimbledon',
  description: 'Get ready to be beaten!',
  time: [0, 15, 30, 45, 60].sample,
  user_id: billiejean.id,
  datetime: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :evening)
)
billiejean_tennis_session.save!

jigsaw = User.new(
  email: 'jigsaw@gmail.com',
  password: '123456',
  address: 'New York',
  first_name: 'Jigsaw',
  last_name: 'Puppet',
  gender: 'Male',
  bio: 'I enjoy playing games with people!',
  birth_date: '1987-05-22',
  competitiveness: 8
)
jigsaw_photo = URI.open('https://sportshub.cbsistatic.com/i/2021/03/17/6a46fa2a-496b-4414-861d-d45268a3fe84/saw-billy-talking-doll-puppet-top-1177198.jpg')
jigsaw.photo.attach(io: jigsaw_photo, filename: 'jigsaw_photo.jpg', content_type: 'image/jpg')
jigsaw.save!

jigsaw_tennis_session = PairingSession.new(
  activity: 'tennis',
  address: 'Wimbledon',
  description: 'Do you want to play a game!',
  time: [0, 15, 30, 45, 60].sample,
  user_id: jigsaw.id,
  datetime: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :evening)
)
jigsaw_tennis_session.save!
