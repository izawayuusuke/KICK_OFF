FactoryBot.define do
  factory :user do
    name { Faker::Lorem.charecters(number:10) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(nubmer:20) }
    password { "password" }
    password_confirmation { "password"}
  end
end
