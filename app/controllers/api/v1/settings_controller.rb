require 'net/http'

module Api
  module V1
    class SettingsController < ApplicationController
      acts_as_token_authentication_handler_for User

      api :POST, '/settings/sarah-state/:state', 'Set the SARAH listening state'
      description 'Set the SARAH listening state if user has the rights'
      meta clients: [:android_application, :web_application], status: :pending
      param :state, [:sleep, :active], desc: 'Listening state', required: true
      def sarah_state

      end

      api :POST, '/settings/twitter-state/:state', 'Set the Twitter daemon state'
      description 'Set the Twitter daemon state if user has the rights'
      meta clients: [:android_application, :web_application], status: :pending
      param :state, [:sleep, :active], desc: 'Daemon state', required: true
      def twitter_state

      end

      api :POST, '/settings/reminders-state/:state', 'Set the Reminders display state'
      description 'Set the Reminders display state if user has the rights'
      meta clients: [:android_application, :web_application], status: :pending
      param :state, [:sleep, :active], desc: 'Reminder display state', required: true
      def reminders_state

      end

      api :POST, '/settings/weather-state/:state', 'Set the weather display state'
      description 'Set the weather display state if user has the rights'
      meta clients: [:android_application, :web_application], status: :pending
      param :state, [:sleep, :active], desc: 'Weather display state', required: true
      def weather_state

      end

      def metting_room_state
        params = { mode: params[:mode] }

        x = Net::HTTP.post_form(URI.parse('http://10.33.0.39:8888/led.py'), params)

        ap x
      end

      api :GET, '/settings/sarah-commands', 'Get the list of vocals commands for SARAH'
      description 'Get a static list of available commands to talk with SARAH'
      meta clients: [:android_application, :web_application], status: :pending
      error code: 200, desc: 'Ok'
      def sarah_commands

      end

      private
        def settings_params
          params.required(:settings).permit!(:state)
        end
    end
  end
end
