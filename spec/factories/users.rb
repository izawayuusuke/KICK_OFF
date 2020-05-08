FactoryBot.define do
  factory :user do
    name { "Alice" }
    email { "TEST@example.com" }
    password { "password" }
    password_confirmation { "password"}
  end
end
