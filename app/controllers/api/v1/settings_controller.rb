require 'net/http'

module Api
  module V1
    class SettingsController < ApplicationController
      before_action :authenticate, :authorize, only: :update
      before_action :set_setting, only: [:show, :update, :update_sarah_enabled]

      api :GET, '/settings/1', 'Get the Setting object'
      example <<-EOS
        {
          "data": {
            "id": "1",
            "type": "settings",
            "attributes": {
              "reminders-enabled": false,
              "room-occupied": false,
              "sarah-enabled": false,
              "screen-guest-enabled": false,
              "twitter-enabled": false
            }
          }
        }
      EOS
      def show
        render json: @setting
      end

      api :PUT, '/settings/1', 'Update the Setting object'
      def update
        if @setting.update setting_params
          # Set the room state, whatever its previous state
          if setting_params.include? :room_occupied
            ap "API::V1::SettingsController#update room_occupied to #{@setting.room_occupied}"

            raspberry_api_connector = RaspberryApiConnector.new

            begin
              raspberry_api_connector.get_room_occupied mode: @setting.room_occupied
            rescue RaspberryApiConnector::Error => e
              render json: { error: 'Service_unavailable' }, status: :service_unavailable and return
            else
              ActionCable.server.broadcast 'room_mode_channel', room_occupied: @setting.room_occupied
            end
          end

          # Set the screen mode, whatever its previous state
          if setting_params.include? :screen_guest_enabled
            if @setting.screen_guest_enabled == true
              mode = :guest
            else
              mode = :normal
            end

            ap "API::V1::SettingsController#update screen_guest_enabled to #{mode}"

            ActionCable.server.broadcast 'screen_mode_channel', mode: mode
          end

          # Set the SARAH state
          if setting_params.include? :sarah_enabled
            ap "API::V1::SettingsController#update sarah_enabled to #{sarah_enabled}"

            voice_recognition_server_api_connector = VoiceRecognitionServerApiConnector.new

            voice_recognition_server_api_connector.get_sleep_mode reveil: @setting.sarah_enabled
          end

          render json: @setting, status: :ok
        else
          render json: @setting.errors, status: :unprocessable_entity
        end
      end

      api :PUT, '/settings/1/sarah_enabled', 'Update the SARAH state'
      def update_sarah_enabled
        @setting.update setting_params_sarah

        render head: :no_content
      end

      private
        def set_setting
          @setting = Setting.first
        end

        def setting_params
          params.permit :reminders_enabled, :room_occupied, :sarah_enabled, :screen_guest_enabled, :twitter_enabled
        end

        def setting_params_sarah
          params.permit :sarah_enabled
        end
    end
  end
end
