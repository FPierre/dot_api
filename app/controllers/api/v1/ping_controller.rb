module Api
  module V1
    class PingController < ApplicationController
      api :GET, '/ping', 'Get the API status'
      description "Make a request to the API to get it's current state"
      error code: 200, desc: 'Ok'
      meta clients: [:android_application, :sarah, :web_application], status: :ok
      def ping
        render json: { data: 'pong' }
      end
    end
  end
end
