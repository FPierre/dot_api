module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        api :POST, '/sign_in', 'Connect an User'
        error code: 422, desc: 'Unprocessable entity'
        error code: 200, desc: 'Ok'
        meta clients: [:android_application, :web_application], status: :ok
        param :email,    String, desc: 'Email',    required: true
        param :password, String, desc: 'Password', required: true
        def create
          # ap 'API::V1::Users::SessionsController#create'
          user = User.find_by email: params[:email]
          # ap user

          if user && user.valid_password?(params[:password])
            sign_in(user, store: false)

            render json: user, status: :ok
          else
            render json: nil, status: :unauthorized
          end
        end

        # DELETE /resource/sign_out
        # def destroy
        #   super
        # end

        # protected

        # If you have extra params to permit, append them to the sanitizer.
        # def configure_sign_in_params
        #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
        # end
      end
    end
  end
end
