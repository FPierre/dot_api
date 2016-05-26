class ApplicationController < ActionController::API
  # http://sourcey.com/building-the-prefect-rails-5-api-only-app/
  # include ActionController::HttpAuthentication::Token::ControllerMethods

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
    # Token token=PVw-GHaSPtDqWeQUgAVG
    def authenticate_by_token
      # authenticate_with_http_token do |token, options|
        # user = User.find_by authentication_token: token, email: params[:email]
        @current_user = User.find_by authentication_token: params[:token], email: params[:email]

        sign_in(@current_user, store: false) if @current_user
      # end
    end

    def render_unauthorized realm = 'Application'
      self.headers['WWW-Authenticate'] = %(Token realm="#{realm.gsub(/"/, "")}")
      render json: 'Unauthorized', status: :unauthorized
    end

    def render_forbidden realm = 'Application'
      self.headers['WWW-Authenticate'] = %(Token realm="#{realm.gsub(/"/, "")}")
      render json: 'Forbidden', status: :forbidden
    end
end
