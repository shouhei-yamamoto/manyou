# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               admin: false
               )
end


@user = User.create!(
  name: "normal",
  email: "normal@example.jp",
  password: "22222222",
  admin: "false"
  )

10.times do |n|
  Label.create!(name:"label#{n}")
end

10.times do |n|
  Task.create!(
    name: "task#{n}",
    content: "content#{n}",
    deadline: DateTime.now + 10,
    status: rand(0..2),
    priority: rand(0..2),
    user_id: @user.id
  )
end