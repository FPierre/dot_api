require 'net/http'

module Api
  module V1
    class SettingsController < ApplicationController
      before_action :authenticate, :authorize
      before_action :set_setting, only: [:show, :update]

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
        else
          render json: @setting.errors, status: :unprocessable_entity
        end
      end

      # def meeting_room_state
      #   params = { mode: params[:mode] }

      #   x = Net::HTTP.post_form(URI.parse('http://10.33.0.39:8888/led.py'), params)

      #   ap x
      # end

      # api :GET, '/settings/sarah-commands', 'Get the list of vocals commands for SARAH'
      # description 'Get a static list of available commands to talk with SARAH'
      # meta clients: [:android_application, :web_application], status: :pending
      # error code: 200, desc: 'Ok'
      # def sarah_commands

      # end

      private
        def set_setting
          @setting = Setting.first
        end

        def setting_params
          params.permit :reminders_enabled, :room_occupied, :sarah_enabled, :screen_guest_enable, :screen_guest_enabled,
                        :twitter_enabled
        end
    end
  end
end
