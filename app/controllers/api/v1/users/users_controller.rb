module Api
  module V1
    module Users
      class UsersController < Devise::SessionsController
        # before_action :configure_sign_in_params, only: [:create]

        api :GET, '/users', 'Get all Users'
        desc "Return a list of all Users if the current user is administrator."
        error code: 403, desc: 'Forbidden'
        error code: 200, desc: 'Ok'
        meta clients: [:android_application, :web_application], status: :pending
        def index
          # TODO Authentification
          render json: User.all
        end
      end
    end
  end
end
