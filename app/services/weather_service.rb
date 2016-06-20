# https://github.com/gitlabhq/gitlabhq/blob/master/app/services/base_service.rb
# https://www.netguru.co/blog/service-objects-in-rails-will-help
# https://blog.engineyard.com/2014/keeping-your-rails-controllers-dry-with-services
# http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/
# http://stevelorek.com/service-objects.html

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
