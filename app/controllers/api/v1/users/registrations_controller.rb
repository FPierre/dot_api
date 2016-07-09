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
    module Users
      class RegistrationsController < Devise::RegistrationsController
        api :POST, '/users', 'Create an User'
        error code: 422, desc: 'Unprocessable entity'
        error code: 201, desc: 'Created'
        meta clients: [:android_application, :web_application], status: :pending
        param :email,     String, desc: 'Email',     required: true
        param :firstname, String, desc: 'Firstname', required: true
        param :lastname,  String, desc: 'Lastname',  required: true
        param :password,  String, desc: 'Password',  required: false
        def create
          user = User.new user_params

          # OPTIMIZE email est de toute façon obligatoire ?
          # OPTIMIZE begin rescue sur la génération d'Avatar
          # FIXME génération de /public/system/... non désirée
          avatar = Avatarly.generate_avatar user_params[:email], size: 256

          File.open("public/images/#{user_params[:email].parameterize}.png", 'wb') do |f|
            f.write avatar
          end

          user.avatar = File.new("public/images/#{user_params[:email].parameterize}.png")

          if user.save
            render json: user, status: :created
          else
            render json: user.errors, status: :unprocessable_entity
          end
        end

        private
          def user_params
            params.permit :email, :firstname, :lastname, :password
          end

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
          # def after_inactive_sign_up_path_for resource
            # super resource

            # respond_to do |format|
            #   format.html { super(resource) }
            #   format.json { render json: resource }
            # end
          # end
      end
    end
  end
end
