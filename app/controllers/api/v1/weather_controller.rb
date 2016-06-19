module Api
  module V1
    class WeatherController < ApplicationController
      def show
        weather_client = WeatherService.new
        data = {
          weather: weather_client.current_weather,
          temp: {
            current: weather_client.current_temp,
            min: weather_client.current_temp_min,
            max: weather_client.current_temp_max
          }
        }

        # ap data

        render json: data, status: :ok
      end
    end
  end
end
