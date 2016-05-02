class ApplicationController < ActionController::API
  # http://sourcey.com/building-the-prefect-rails-5-api-only-app/
  include ActionController::HttpAuthentication::Token::ControllerMethods

  attr_accessor :current_user

  protected
    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        @current_user = User.find_by authentication_token: token
      end
    end

    def render_unauthorized realm = 'Application'
      self.headers['WWW-Authenticate'] = %(Token realm="#{realm.gsub(/"/, "")}")
      render json: 'Unauthorized', status: :unauthorized
    end

    def authorize
      authorize_admin || render_forbidden
    end

    def authorize_admin
      @current_user.present? && @current_user.admin?
    end

    def render_forbidden realm = 'Application'
      self.headers['WWW-Authenticate'] = %(Token realm="#{realm.gsub(/"/, "")}")
      render json: 'Forbidden', status: :forbidden
    end
end
