FactoryBot.define do
  factory :coin do
    name { Faker::Lorem.word }
    value { rand(5..1000) }
  end
end