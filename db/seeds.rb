# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password_digest = "password"
  User.create!(name: name,
               email: email,
               password_digest: password_digest,
               )
end