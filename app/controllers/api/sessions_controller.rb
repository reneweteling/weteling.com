module Api
  class SessionsController < Devise::SessionsController
    protect_from_forgery with: :null_session

    def create
      user = User.find_by_email(params[:email])

      if user && user.valid_password?(params[:password])
        @current_user = user
        
        render json: {
          id: user.id,
          email: user.email,
          first_name: user.first_name,
          last_name: user.last_name,
          token: user.generate_jwt
        }
      else
        render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
      end
    end
  end
end