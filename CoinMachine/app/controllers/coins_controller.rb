class CoinsController < ApplicationController
    before_action :authenticate
    
    def index
        coins = Coin.all
        total_values = Coin.total_values
        render json: {coins: coins, total_values: total_values}
    end

    def show
        coin = Coin.find_by(id: params[:id])
        render json: coin
    end

    def create
        coin = Coin.new(coin_params)
        if coin.save
            render json: coin.to_json
        else
            render json: {errors: coin.errors.to_json}, status: :unprocessable_entity
        end
    end

    def update
        coin = Coin.find_by(id: params[:id])
        coin.update(coin_params)
        render json: coin
    end

    def destroy
        coin = Coin.find_by(id: params[:id])
        coin.destroy
        render json: {message: 'The Coin has been deleted successfully'}
    end

    private
    
    def coin_params
        params.require(:coin).permit(:name, :value)
    end
end