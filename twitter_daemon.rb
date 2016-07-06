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

TWITTER_USERS_ID = [
  124717202,  # @s_dumontier
  27488470,   # @Fred_Burtz
  3004133231, # itnovem
  304499208,  # @Florence_two
  335948578,  # @OReinsbach
  432492827,  # @SNCF_infopresse
  4924388109, # @Emma_Turlotte
  533047414,  # SNCF_Digital
  69107325,   # JPLouva
]

# daemon.track('SNCF') do |tweet|
daemon.follow(TWITTER_USERS_ID) do |tweet|
  return unless Setting.first.twitter_enabled

  puts "#{tweet.text}"

  notification = {
    content: tweet.text,
    created_at: DateTime.now,
    duration: 1000,
    priority: 3,
    user: 'Twitter'
  }

  ActionCable.server.broadcast 'notification_channel', notification: notification
end
