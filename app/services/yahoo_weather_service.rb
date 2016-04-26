# https://github.com/gitlabhq/gitlabhq/blob/master/app/services/base_service.rb

# https://www.netguru.co/blog/service-objects-in-rails-will-help

# https://blog.engineyard.com/2014/keeping-your-rails-controllers-dry-with-services

# http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/

# http://stevelorek.com/service-objects.html

class YahooWeatherService
  def initialize
    @client = YahooWeather::Client.new
  end

  def fetch
    # https://github.com/manzhikov/yahoo_weather/blob/master/lib/yahoo_weather/client.rb
    @client.fetch 615702, YahooWeather::Units::CELSIUS
  end
end
