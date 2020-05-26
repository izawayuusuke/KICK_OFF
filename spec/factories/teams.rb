FactoryBot.define do
  factory :team do
    name { Faker::Sports::Football.team }
    association :league
  end
end
