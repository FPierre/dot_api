require 'tweetstream'

ENV['RAILS_ENV'] ||= 'production'

# root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
root = File.expand_path(File.join(File.dirname(__FILE__), '.'))

require File.join(root, 'config', 'environment')

TweetStream.configure do |config|
  config.consumer_key       = 'b03z1apXYtpHHFWJY0LYRN4uI'
  config.consumer_secret    = 'ADJm66KjZjZxId3MfIuoZZ7W2pvTBavSGtq2Plk44n0fXllO24'
  config.oauth_token        = '4853273541-Bbab8VYmVwZt3e4FUkVnzg5WPKR3a0Ds48mG2Ax'
  config.oauth_token_secret = '45rJCCPJJjUMK9qndAqmEKrzbsaLi0YgzEf4qF68Dv8Aa'
  config.auth_method        = :oauth
end

# TweetStream::Daemon.new('tracker').track('SNCF') do |status|
#   puts "#{status.text}"

#   ActionCable.server.broadcast 'notification_channel', author: 'SNCF', message: status.text, duration: 10000

#   head :ok
# end

daemon = TweetStream::Daemon.new('tracker', log_output: true)

daemon.on_inited do
  # ActiveRecord::Base.connection.reconnect!
  # ActiveRecord::Base.logger = Logger.new(File.open('log/stream.log', 'w+'))
end

daemon.track('SNCF') do |tweet|
  # Status.create_from_tweet(tweet)

  puts "#{tweet.text}"

  ActionCable.server.broadcast 'notification_channel', author: 'SNCF', message: tweet.text, duration: 10000
end
