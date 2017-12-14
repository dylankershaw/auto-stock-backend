class Api::V1::AuthenticationController < ApplicationController

  def create
    # byebug
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      render json: {
        id: user.id,
        username: user.username,
        token: JWT.encode({user_id: user.id}, ENV['JWT_SECRET'], ENV['JWT_ALGORITHM'])
      }
    else
      render json: {error: 'User not found'}, status: 404
    end
  end

#   def show
#     if current_user
#       render json: {
#         id: current_user.id,
#         username: current_user.username
#       }
#     else
#       render json: {error: 'No id present on headers'}, status: 404
#     end
#   end


end