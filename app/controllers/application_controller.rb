class ApplicationController < ActionController::API
  attr_accessor :current_user

  protected
    def authenticate
      authenticate_by_token || render_unauthorized
    end

    def authorize
      @current_user.approved? || render_forbidden
    end

    def authorize_admin
      (self.authorize && @current_user.admin?) || render_forbidden
    end

  private
    def authenticate_by_token
      @current_user = User.find_by authentication_token: params[:user_token], email: params[:user_email]
      sign_in(@current_user, store: false) if @current_user
    end

    def render_unauthorized realm = 'Application'
      self.headers['WWW-Authenticate'] = %(Token realm="#{realm.gsub(/"/, "")}")

      render json: { droits: 'Unauthorized' }, status: :unauthorized
    end

    def render_forbidden realm = 'Application'
      self.headers['WWW-Authenticate'] = %(Token realm="#{realm.gsub(/"/, "")}")

      render json: { droits: 'Forbidden' }, status: :forbidden
    end
end
