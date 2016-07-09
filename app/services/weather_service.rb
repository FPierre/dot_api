require 'open_weather'

class WeatherService
  attr_accessor :response

  def initialize
    @response = process
  end

  def current_weather
    @response.dig :weather, 0
  end

  def current_temp
    @response.dig :main, :temp
  end

  def current_temp_min
    @response.dig :main, :temp_min
  end

  def current_temp_max
    @response.dig :main, :temp_max
  end

  private
    def process
      OpenWeather::Current.city('Paris, FR', {
        APPID: ENV['openweathermap_api_key'],
        lang: 'fr',
        units: 'metric'
      }).with_indifferent_access
    end
end
