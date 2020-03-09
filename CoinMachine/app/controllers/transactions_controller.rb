class TransactionsController < ApplicationController
    include TransactionUtils

    def index
        transactions = Transaction.all
        render json: transactions
    end

    def show
        transaction = Transaction.find_by(id: params[:id])
        render json: transaction
    end

    def create
        transaction = Transaction.new(transaction_params)

        if !transaction.is_deposit && !is_valid_transaction?(transaction.coin.name) 
            return render json: invalid_transction_error, status: :bad_request
        end 

        if transaction.save
            coins_with_low_balances = low_balances
            balances = get_coin_counts.to_json

            coins_with_low_balances.each { |coin| 
                BalanceMailer.low_balance(transaction, total_values, balances ).deliver
            }

            render json: transaction.to_json
        else
            render json: {errors: transaction.errors.to_json}, status: :unprocessable_entity 
        end
    end

    private

    def transaction_params
        params.require(:transaction).permit(:user_id, :coin_id, :is_deposit)
    end

end
