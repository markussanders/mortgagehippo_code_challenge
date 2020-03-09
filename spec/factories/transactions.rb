FactoryBot.define do
  factory :transaction do
    user { nil }
    coin { nil }
    is_deposit {Faker::Boolean.boolean(true_ratio: 0.5)}
  end
end
