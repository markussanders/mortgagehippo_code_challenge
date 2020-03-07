module TransactionUtils
    def get_coin_count
        Transaction.all.reduce(Hash.new(0)) { |hash, transaction| 
            transaction[:is_deposit] ? hash[transaction[:coin_id]] += 1 : hash[transaction[:coin_id]] -= 1
            hash
        }
    end

    def get_transactions(coin_id)
        Transaction.all.select { |transaction| transaction.coin_id == coin_id }
    end

    def is_valid_transaction?(coin_id)
        coin_counts = get_coin_count
        coin_counts[coin_id] >= 1
    end

    def invalid_transction_error
        {errors: "There are not enough coins to complete this withdrawal."}
    end
end