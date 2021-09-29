class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      render json: { user: user }, code: 201
    else
      render json: { errors: user.errors }, code: 403
    end
  end

  private
  
  def user_params
    params.permit(:name, :avatar, :bio, :whatsapp)
  end
end
