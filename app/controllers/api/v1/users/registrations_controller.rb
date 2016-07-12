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
            params.permit :admin, :approved, :email, :firstname, :lastname, :password
          end
      end
    end
  end
end
