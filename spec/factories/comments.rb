FactoryBot.define do
  factory :comment do
    user { nil }
    post { nil }
    comment { "MyString" }
    text { "MyString" }
  end
end
