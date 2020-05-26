FactoryBot.define do
  factory :message do
    association :user
    association :room
    content { Faker::Lorem::characters(number: 10) }
  end
end
