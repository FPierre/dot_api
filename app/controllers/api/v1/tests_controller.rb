module Api
  module V1
    class TestsController < ApplicationController
      before_action :authenticate, :authorize

      api :GET, '/ping', 'Get the API status'
      description "If the API is up, returns 'pong'"
      error code: 200, desc: 'Ok'
      example <<-EOS
        {
          "data": "pong"
        }
      EOS
      meta clients: [:android_application, :sarah, :web_application], status: :ok
      def ping
        render json: { data: 'pong' }
      end

      api :POST, '/voice'
      def voice
        # TODO Call SARAH
      end
    end
  end
end
