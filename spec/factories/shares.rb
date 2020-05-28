FactoryBot.define do
  factory :share do
    association :post
    association :user
  end
end
