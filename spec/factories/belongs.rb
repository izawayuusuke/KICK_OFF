FactoryBot.define do
  factory :belong do
    association :player
    association :team
  end
end
