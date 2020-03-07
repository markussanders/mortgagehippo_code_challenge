User.destroy_all
Coin.destroy_all
Transaction.destroy_all

markus = User.create!(is_admin: true, name: 'markus', email: 'markus.sanderst@gmail.com')
test_coin = Coin.create!(name:'test', value: 999, user_id: markus.id)
Transaction.create!(user_id: markus.id, coin_id: test_coin.id)