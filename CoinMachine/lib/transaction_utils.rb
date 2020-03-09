module TransactionUtils
    def get_coin_counts
        Transaction.all.reduce(Hash.new(0)) { |hash, transaction| 
            coin = transaction.coin.name
            transaction[:is_deposit] ? hash[coin] += 1 : hash[coin] -= 1
            hash
        }
    end

    def low_balances 
        coin_counts = get_coin_counts
        coin_counts.select { |coin| coin_counts[coin] <= 4 }
    end

    def is_valid_transaction?(coin_name)
        coin_counts = get_coin_counts
        coin_counts[coin_name] - 1 >= 0
    end

    def invalid_transction_error
        {errors: "There are not enough coins to complete this withdrawal."}.to_json
    end

    def total_values
        total = 0
        coin_counts = get_coin_counts

        coin_counts.each { |coin_name, amount| 
            current_coin = Coin.find_by(name: coin_name)
            current_coin_value = current_coin.value
            total += current_coin_value * amount
        }
        total
    end 
end