module Api
  module V1
    class Users::SessionsController < Devise::SessionsController
      # resource_description do
      #   resource_id 'Users'
      # end

      # before_action :configure_sign_in_params, only: [:create]

      api :POST, '/users/sign_in', 'Connect an User'
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
