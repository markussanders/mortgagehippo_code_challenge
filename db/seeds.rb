require 'faker'

User.destroy_all
Coin.destroy_all
Transaction.destroy_all

markus = User.create!(is_admin: true, name: 'markus', email: 'markus.sanderst@gmail.com')

10.times do 
    User.create(name: Faker::Name.unique.name, email: Faker::Internet.email, is_admin: Faker::Boolean.boolean(true_ratio: 0.1))
end

5.times do 
    Coin.create!(name: Faker::Lorem.word, value: Faker::Number.within(range: 1..1000), user_id: User.all.sample.id)
end

40.times do 
    Transaction.create!(user_id: User.all.sample.id, coin_id: Coin.all.sample.id, is_deposit: Faker::Boolean.boolean(true_ratio: 0.7))
end