# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "faker"
# TODO: Write a seed to insert 100 posts in the database

# seed cars
# seed user
puts "creating users & cars"
Booking.destroy_all
Car.destroy_all
User.destroy_all
5.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: "password"
    # no need ==> reset_password_token:
  )
  3.times do
    Car.create!(
      car_model: Faker::Vehicle.make_and_model,
      capacity: rand(4..8),
      description: Faker::Vehicle.car_options.join(", "),
      price_per_day: rand(1111..9999),
      user: user
    )
  end
end
puts "users & cars created"

puts "creating bookings"
10.times do
  Booking.create!(
    start_date: Date.today + rand(1..30).days,
    end_date: Date.today + rand(31..60).days,
    status: rand(0..2),
    user: User.all.sample,
    car: Car.all.sample
  )
end
10.times do
  Booking.create!(
    start_date: Date.today - rand(31..60).days,
    end_date: Date.today - rand(1..30).days,
    status: rand(0..2),
    user: User.all.sample,
    car: Car.all.sample
  )
end
puts "created bookings"
