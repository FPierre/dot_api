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

daemon = TweetStream::Daemon.new 'tracker', {
  dir: File.join(root, 'tmp', 'pids'),
  log_dir: File.join(root, 'log'),
  log_output: true,
  output_logfilename: 'twitter_daemon.log'
}

daemon.on_inited do
  # ActiveRecord::Base.connection.reconnect!
  # ActiveRecord::Base.logger = Logger.new(File.open('log/stream.log', 'w+'))
end

daemon.track('SNCF') do |tweet|
  puts "#{tweet.text}"
  # puts 'twitter'
  # puts Setting.first.id

  # return unless Setting.first.twitter_enabled

  notification = {
    content: tweet.text,
    created_at: DateTime.now,
    duration: 1000,
    priority: 3,
    user: 'Twitter'
  }

  ActionCable.server.broadcast 'notification_channel', notification: notification
end
