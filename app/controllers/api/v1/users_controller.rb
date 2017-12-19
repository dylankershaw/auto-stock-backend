class Api::V1::UsersController < ApplicationController
    def show
        user = User.find(params[:id])
        render json: user
    end

    def create
        user = User.create(username: params["username"], password: params["password"])
        render json: {
            id: user.id,
            username: user.username,
            token: JWT.encode({user_id: user.id, user_username: user.username}, ENV['JWT_SECRET'], ENV['JWT_ALGORITHM'])
        }
    end
end
