# https://github.com/lucek/avatarly/blob/master/lib/avatarly.rb
class Avatarly
  def self.generate_avatar text, opts = {}
    if opts[:lang]
      text = UnicodeUtils.upcase(self.send(:initials, text.to_s.strip), opts[:lang])
    else
      text = self.send(:initials, text.to_s.strip).upcase
    end

    self.send(:generate_image, text, parse_options(opts)).to_blob
  end
end

module Api
  module V1
    class Users::RegistrationsController < Devise::RegistrationsController
      # respond_to :json

      skip_before_action :verify_authenticity_token

      # resource_description do
      #   resource_id 'Users'
      # end

      # before_action :configure_sign_up_params, only: [:create]
      # before_action :configure_account_update_params, only: [:update]

      api :POST, '/users', 'Create an User'
      def create
        user = User.new params[:user]

        respond_to do |format|
          if user.save
            format.html {  }
            format.json { render json: user, status: :created }
          else
            format.html {  }
            format.json { render json: user.errors, status: :unprocessable_entity }
          end
        end




        # super

        # respond_to do |format|
        #   format.html { redirect_to root_path and return }
        #   format.json { render json: resource and return }
        # end

        # super do |resource|
        #   avatar = Avatarly.generate_avatar resource.email, size: 256

        #   File.open("public/images/#{resource.email.parameterize}.png", 'wb') do |f|
        #     f.write avatar
        #   end

        #   resource.update avatar: File.new("public/images/#{resource.email.parameterize}.png")

        #   # respond_to do |format|
        #   #   format.html { redirect_to root_path }
        #   #   format.json { render json: resource }
        #   # end
        # end
      end

      api :PUT, '/users', 'Update an User'
      def update
        super
      end

      # DELETE /resource
      # def destroy
      #   super
      # end

      # GET /resource/cancel
      # Forces the session data which is usually expired after sign
      # in to be expired now. This is useful if the user wants to
      # cancel oauth signing in/up in the middle of the process,
      # removing all OAuth session data.
      # def cancel
      #   super
      # end

      protected
      # If you have extra params to permit, append them to the sanitizer.
      # def configure_sign_up_params
      #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
      # end

      # If you have extra params to permit, append them to the sanitizer.
      # def configure_account_update_params
      #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
      # end

      # The path used after sign up.
      # def after_sign_up_path_for(resource)
      #   super(resource)
      # end

        # The path used after sign up for inactive accounts.
        def after_inactive_sign_up_path_for resource
          # super resource

          # respond_to do |format|
          #   format.html { super(resource) }
          #   format.json { render json: resource }
          # end
        end
    end
  end
end
