FactoryBot.define do
  factory :team do
    name { "MyString" }
    is_domestic? { false }
    is_representative? { false }
  end
end
