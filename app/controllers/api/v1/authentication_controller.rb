class Api::V1::AuthenticationController < ApplicationController

  def create
    # finds user
    user = User.find_by(username: params[:username].downcase)
    
    # authenticates user and returns jwt token
    if user && user.authenticate(params[:password])
        render json: {
        id: user.id,
        username: user.username,
        token: JWT.encode({user_id: user.id, user_username: user.username}, ENV['JWT_SECRET'], ENV['JWT_ALGORITHM'])
      }
    else
      render json: {error: 'User not found'}, status: 401
    end
  end

  def show
    # decodes JWT token
    current_user = JWT.decode(params["token"], ENV['JWT_SECRET'], ENV['JWT_ALGORITHM'])

    # returns user id and username
    if current_user
      render json: {
        id: current_user[0]["user_id"],
        username: current_user[0]["user_username"]
      }
    else
        render json: {error: 'invalid token'}, status: 401
    end
  end


end