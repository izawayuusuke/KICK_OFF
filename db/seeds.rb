# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "KICK OFF",
            email: "kick@off.com",
            password: "kickoff",
            password_confirmation: "kickoff",
            admin: true)

10.times do |n|
  name = Faker::Name.name
  email = "ball#{n+1}@example.com"
  password = "password"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password)
end
