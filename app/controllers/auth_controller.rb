class AuthController < ApplicationController
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = JWT.encode({ user_id: user.id, role: user.role }, Rails.application.secret_key_base)
      render json: { token: token, user: { id: user.id, name: user.name, role: user.role } }
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end
end
