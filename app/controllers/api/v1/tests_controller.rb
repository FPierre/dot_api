module Api
  module V1
    class TestsController < ApplicationController
      before_action :authenticate, :authorize

      api :GET, '/tests/ping', 'Get the API status'
      description "If the API is up, returns 'pong'"
      error code: 200, desc: 'Ok'
      meta access: [:approved, :admin]
      example <<-EOS
        {
          "data": "pong"
        }
      EOS
      def ping
        render json: { data: 'pong' }
      end

      api :POST, '/tests/voice', 'Send text to be repeated by the voice recognition'
      meta access: [:approved, :admin]
      def voice
        # Connecte to SARAH API
        voice_recognition_server_api_connector = VoiceRecognitionServerApiConnector.new

        # Send text to SARAH
        voice_recognition_server_api_connector.get_text_to_speech text: params[:text]
      end
    end
  end
end
