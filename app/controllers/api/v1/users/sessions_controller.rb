module Api
  module V1
    class Users::SessionsController < Devise::SessionsController
      api :POST, '/users/sign_in', 'Connect an User'
      error code: 422, desc: 'Unprocessable entity'
      error code: 200, desc: 'Ok'
      meta clients: [:android_application, :web_application], status: :pending
      param :email,    String, desc: 'Email',    required: true
      param :password, String, desc: 'Password', required: true
      def create
        super
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
