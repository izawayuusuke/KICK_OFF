# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "KICK OFF",
            email: "kickoff@eleven.com",
            password: "kickoff",
            password_confirmation: "kickoff",
            admin: true)

50.times do |n|
  name = Faker::Name.name
  introduction = Faker::Lorem::sentence
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password)
end

User.all.each do |user|
  user.posts.create!(user_id: user.id,
                    content: Faker::Lorem::sentence,
                    image: File.open('./app/assets/images/no_post_image.png'))
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

posts = Post.all

like_users = users[2..40]
like_users.each do |user|
  posts.each { |post| Like.create(user_id: user.id, post_id: post.id) }
end

share_users = users[3..30]
share_users.each do |user|
  posts.each { |post| Share.create(user_id: user.id, post_id: post.id) }
end

comment_users = users[5..50]
comment_users.each do |user|
  posts.each { |post| Comment.create(user_id: user.id, post_id: post.id, comment: Faker::Lorem::sentence) }
end
