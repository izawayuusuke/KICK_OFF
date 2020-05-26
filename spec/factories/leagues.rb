FactoryBot.define do
  factory :league do
    name { Faker::Lorem::characters(number: 10) }
    classification { ["domestic", "abroad", "representative"].sample }
  end
end
