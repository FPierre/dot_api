module Api
  module V1
    module Users
      class UsersController < ApplicationController
        before_action :authenticate
        before_action :authorize, only: [:show, :index, :update]
        before_action :authorize_admin, only: :destroy
        before_action :set_user, only: [:show, :update, :destroy]

        api :GET, '/users', 'Get an User'
        # desc "Return a list of all Users if the current user is administrator."
        # error code: 403, desc: 'Forbidden'
        # error code: 200, desc: 'Ok'
        def show
          render json: @user
        end

        api :GET, '/users', 'Get all Users'
        error code: 403, desc: 'Forbidden'
        error code: 200, desc: 'Ok'
        def index
          render json: User.all
        end

        api :PUT, '/users/:id', 'Update an User'
        def update
          # If non admin User tries to update other users
          if !@current_user.admin? && @current_user.id != params[:id].to_i
            render json: { droits: 'Forbidden' }, status: :forbidden and return
          end

          if @user.update user_params
            render json: @user, status: :ok
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        end

        api :DELETE, '/users/:id', 'Delete an User'
        error code: 200, desc: 'Ok'
        def destroy
          if @user.destroy
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
            params.permit :admin, :approved, :email, :firstname, :lastname, :password
          end
      end
    end
  end
end
