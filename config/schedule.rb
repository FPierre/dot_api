set :output, 'log/cron.log'

every 2.hours do
  rake 'actioncable:get_weather'
end
