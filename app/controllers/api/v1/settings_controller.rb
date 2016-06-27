require 'net/http'

module Api
  module V1
    class SettingsController < ApplicationController
      before_action :authenticate, only: [:show, :update]
      before_action :authorize,    only: [:show, :update]
      before_action :set_setting,  only: [:show, :update, :update_sarah_enabled]

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
      meta clients: [:android_application, :web_application], status: :pending
      def update
        if @setting.update setting_params
          render json: @setting, status: :ok

          # Set the room state, whatever its previous state
          if setting_params.include? :room_occupied
            ap "API::V1::SettingsController#update room_occupied to #{@setting.room_occupied}"
            raspberry_api_connector = RaspberryApiConnector.new

            raspberry_api_connector.get_room_occupied mode: @setting.room_occupied
          end

          # Set the screen mode, whatever its previous state
          if setting_params.include? :screen_guest_enabled
            if @setting.screen_guest_enabled == true
              mode = :guest
            else
              mode = :team
            end

            ap "API::V1::SettingsController#update screen_guest_enabled to #{mode}"

            ActionCable.server.broadcast 'screen_mode_channel', mode: mode
          end
        else
          render json: @setting.errors, status: :unprocessable_entity
        end
      end

      api :PUT, '/settings/1/sarah_enabled', 'Update the SARAH state'
      meta clients: [:sarah], status: :pending
      def update_sarah_enabled
        @setting.update setting_params_sarah

        render head: :no_content
      end

      private
        def set_setting
          @setting = Setting.first
        end

        def setting_params
          params.permit :reminders_enabled, :room_occupied, :sarah_enabled, :screen_guest_enable, :screen_guest_enabled,
                        :twitter_enabled
        end

        def setting_params_sarah
          params.permit :sarah_enabled
        end
    end
  end
end
