class UsersController < ApplicationController

    def index
        users = User.all.map { |user| 
            {name: user.name, email: user.email}
        }
        render json: users
    end

    def show
        user = User.find_by(id: params[:id])
        render json: user, only: [:name, :email], include: [:coins, :transactions]
    end

    def create
        user = User.new(user_params)
        if user.save
            render json: user.to_json
        else
            render json: {errors: user.errors.to_json}, status: :unprocessable_entity
        end
    end

    def update
        user = User.find_by(id: params[:id])
        user.update(user_params)
        render json: user
    end

    def destroy
        user = User.find_by(id: params[:id])
        user.destroy
        render json: {message: 'Account deleted successfully'}
    end

    private
    
    def user_params
        params.require(:user).permit(:name, :email)
    end
end
