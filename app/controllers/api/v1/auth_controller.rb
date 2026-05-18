
class Api::V1::AuthController < ApplicationController

  def signup
    user = User.new(user_params)

    if user.save
      token = encode_token(user_id: user.id)

      render json: {
        user: {
          id: user.id,
        name: user.name,
        email: user.email,
        role: user.role
        },
        token: token
      }, status: :created
    else
      render json: {
        errors: user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :role)
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end