FactoryBot.define do
  factory :player do
    name { Faker::Sports::Football.player }
    age { Faker::Number.within(range: 20..40) }
    height { Faker::Number.within(range: 150..200) }
    weight { Faker::Number.within(range: 40..90) }
    dominant_foot { ["right_foot", "left_foot", "both_foot"].sample }
    position { ["GK", "DF", "MF", "FW"].sample }
    uniform_number { Faker::Number.within(range: 1..99) }
  end
end
