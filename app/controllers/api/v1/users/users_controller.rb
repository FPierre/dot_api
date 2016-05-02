module Api
  module V1
    module Users
      class UsersController < ApplicationController
        before_action :authenticate, :authorize

        api :GET, '/users', 'Get all Users'
        desc "Return a list of all Users if the current user is administrator."
        error code: 403, desc: 'Forbidden'
        error code: 200, desc: 'Ok'
        meta clients: [:android_application, :web_application], status: :pending
        def index
          render json: User.all
        end
      end
    end
  end
end
