namespace :actioncable do
  desc 'Send fresh weather data to Websockets clients'
  task get_weather: :environment do
    weather_client = WeatherService.new
    data = {
      data: {
        weather: weather_client.current_weather,
        temp: {
          current: weather_client.current_temp,
          min: weather_client.current_temp_min,
          max: weather_client.current_temp_max
        }
      }
    }

    # ap data

    ActionCable.server.broadcast 'weather_channel', weather: data
  end
end
