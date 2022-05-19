# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "faker"
require "open-uri"

IMAGE_URLS = ['https://tech.hyundaimotorgroup.com/wp-content/uploads/2020/09/09-6.jpg', 'https://images.unsplash.com/photo-1527786356703-4b100091cd2c?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074', 'https://images.unsplash.com/photo-1513311068348-19c8fbdc0bb6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80', 'https://images.unsplash.com/photo-1625834509314-3b12c6153624?ixlib=rb-1.2.1&raw_url=true&q=80&fm=jpg&crop=entropy&cs=tinysrgb&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1932', 'https://images.unsplash.com/photo-1523987355523-c7b5b0dd90a7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80', 'https://images.unsplash.com/photo-1532115298834-4c70d11ec8f3?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470']

# seed cars
# seed users
# seed bookings
puts "creating users & cars"
Booking.destroy_all
Car.destroy_all
User.destroy_all
User.create!(email: 'nocamp@nolife.com', password: 'nolife')
4.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: "password"
    # no need ==> reset_password_token:
  )
  20.times do
    car = Car.create!(
      car_model: Faker::Vehicle.make_and_model,
      capacity: rand(4..8),
      description: Faker::Vehicle.car_options.join(", "),
      price_per_day: rand(1111..9999),
      user: user,
      address: Faker::Address.city
    )
    file = URI.open(IMAGE_URLS.sample)
    car.photo.attach(io: file, filename: 'filename.jpg', content_type: 'image/jpg')
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

# extra images
# 'https://images.unsplash.com/photo-1569346306867-b2c7a6b22099?ixlib=rb-1.2.1&raw_url=true&q=80&fm=jpg&crop=entropy&cs=tinysrgb&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735', 'https://mytrailco.com/wp-content/uploads/2020/04/The-best-cars-for-car-camping.jpg', 'https://cars.usnews.com/images/article/202107/128975/1_2021_ford_expedition.jpg', 'https://i0.wp.com/travelfrance.tips/wp-content/uploads/2018/08/Driving-Camping-car.jpg?fit=1023%2C628&ssl=1'
