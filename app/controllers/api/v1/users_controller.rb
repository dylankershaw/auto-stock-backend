class Api::V1::UsersController < ApplicationController
    def show
        user = User.find(params[:id])
        render json: user
    end

    def create
        user = User.new(username: params["username"].downcase, password: params["password"])

        if user.save
            render json: {
                id: user.id,
                username: user.username,
                token: JWT.encode({user_id: user.id, user_username: user.username}, ENV['JWT_SECRET'], ENV['JWT_ALGORITHM'])
            }
        else
            render json: {error: 'Username already taken'}, status: 400
        end
    end
end
