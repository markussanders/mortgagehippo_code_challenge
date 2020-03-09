FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.email }
    is_admin {Faker::Boolean.boolean(true_ratio: 0.2)}
  end
end