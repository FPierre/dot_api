module Api
  module V1
    class TestsController < ApplicationController
      before_action :authenticate, :authorize

      api :GET, '/tests/ping', 'Get the API status'
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

      api :POST, '/tests/voice'
      def voice
        # TODO Call SARAH
        ap params[:text]

        voice_recognition_server_api_connector = VoiceRecognitionServerApiConnector.new

        voice_recognition_server_api_connector.get_text_to_speech params[:text]
      end
    end
  end
end
