FactoryBot.define do
  factory :comment do
    association :post
    association :user
    comment { Faker::Lorem::characters(number: 10) }
  end
end
