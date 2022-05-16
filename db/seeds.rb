# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# seed cars
require "faker"
# TODO: Write a seed to insert 100 posts in the database
puts "creating cars"
user = User.new(email: "haha@gmail.com", password: "haha")
20.times do
  Car.create(
    car_model: Faker::Vehicle.make_and_model,
    capacity: rand(4..8),
    description: Faker::Vehicle.car_options,
    price_per_day: rand(1111..9999),
    user: user
  )
end
puts "cars created"


# t.string :car_model
# t.integer :capacity
# t.text :description
# t.integer :price_per_day
