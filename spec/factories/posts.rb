FactoryBot.define do
  factory :post do
    content { Faker::Lorem.characters(number:5) }
    association :user
  end
end
