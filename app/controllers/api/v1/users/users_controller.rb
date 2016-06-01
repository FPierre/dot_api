module Api
  module V1
    module Users
      class UsersController < ApplicationController
        # before_action :authenticate
        # before_action :authorize, only: :index

        before_action :set_user, only: [:show, :update]

        def current_user
          # render json: @current_user
        end

        api :GET, '/users', 'Get an User'
        # desc "Return a list of all Users if the current user is administrator."
        # error code: 403, desc: 'Forbidden'
        # error code: 200, desc: 'Ok'
        # meta clients: [:android_application, :web_application], status: :pending
        def show
          render json: @user
        end

        api :GET, '/users', 'Get all Users'
        desc "Return a list of all Users if the current user is administrator."
        error code: 403, desc: 'Forbidden'
        error code: 200, desc: 'Ok'
        meta clients: [:android_application, :web_application], status: :pending
        def index
          render json: User.all
        end

        api :PUT, '/users/:id', 'Update an User'
        meta clients: [:android_application, :web_application], status: :pending
        def update
          if @user.update user_params
            render json: @user, status: :ok
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        end

        private
          def set_user
            @user = User.find params[:id]
          end

        def user_params
          params.permit :admin, :approved, :email, :firstname, :lastname
        end
      end
    end
  end
end
