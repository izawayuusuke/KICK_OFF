FactoryBot.define do
  factory :discussion do
    association :user
    association :team
    content { Faker::Lorem::characters(number: 10) }
  end
end
