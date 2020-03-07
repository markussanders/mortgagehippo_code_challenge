class TransactionsController < ApplicationController

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
        if transaction.save 
            render json: transaction.to_json
        else
            render json: {errors: transaction.errors.to_json}, status: :unprocessable_entity 
        end
    end

    private

    def transaction_params
        params.require(:transaction).permit(:user_id, :coin_id)
    end

end
