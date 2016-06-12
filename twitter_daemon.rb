require 'tweetstream'

ENV['RAILS_ENV'] ||= 'production'

root = File.expand_path(File.join(File.dirname(__FILE__), '.'))

require File.join(root, 'config', 'environment')

TweetStream.configure do |config|
  config.consumer_key       = ENV['twitter_consumer_key']
  config.consumer_secret    = ENV['twitter_consumer_secret']
  config.oauth_token        = ENV['twitter_oauth_token']
  config.oauth_token_secret = ENV['twitter_oauth_token_secret']
  config.auth_method        = :oauth
end

# TweetStream::Daemon.new('tracker').track('SNCF') do |status|
#   puts "#{status.text}"

#   ActionCable.server.broadcast 'notification_channel', author: 'SNCF', message: status.text, duration: 10000

#   head :ok
# end

daemon = TweetStream::Daemon.new 'tracker', log_output: true

daemon.on_inited do
  # ActiveRecord::Base.connection.reconnect!
  # ActiveRecord::Base.logger = Logger.new(File.open('log/stream.log', 'w+'))
end

daemon.track('SNCF') do |tweet|
  puts "#{tweet.text}"

  notification = {
    content: tweet.text,
    created_at: Datetime.now,
    duration: 10000,
    priority: 3,
    user: 'Twitter'
  }

  ActionCable.server.broadcast 'notification_channel', notification
end
