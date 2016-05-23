require 'net/http'

module Api
  module V1
    class SettingsController < ApplicationController
      # before_action :authenticate, :authorize_admin

      before_action :set_setting, only: [:show, :update]

      api :GET, '/users', 'Get a Setting'
      def show
        render json: @setting
      end

      api :PUT, '/settings/:id', 'Update a Setting'
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
          @setting = Setting.find params[:id]
        end

        def setting_params
          params.permit :reminders_enabled, :sarah_enabled, :twitter_enabled, :weather_current_day_only, :weather_enabled
        end
    end
  end
end
