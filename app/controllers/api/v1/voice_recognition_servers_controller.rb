module Api
  module V1
    class VoiceRecognitionServersController < ApplicationController
      before_action :set_voice_recognition_server, only: [:show, :update]

      api :GET, '/voice_recognition_servers/1', 'Get the Voice Recognition Server object'
      example <<-EOS
        {
          "data": {
            "id": "1",
            "type": "voice_recognition_servers",
            "attributes": {
              "ip_address": nil,
              "mac_address": nil,
            }
          }
        }
      EOS
      def show
        render json: @voice_recognition_server
      end

      api :PUT, '/voice_recognition_servers/1', 'Update the Voice Recognition Server object'
      meta clients: [:sarah, :web_application], status: :pending
      def update
        if @voice_recognition_server.update voice_recognition_server_params
          render json: @voice_recognition_server, status: :ok
        else
          render json: @voice_recognition_server.errors, status: :unprocessable_entity
        end
      end

      private
        def set_voice_recognition_server
          @voice_recognition_server = VoiceRecognitionServer.first
        end

        def voice_recognition_server_params
          params.permit :ip_address, :mac_address
        end
    end
  end
end
