app_root = '/var/www/dot_api'
pidfile "#{app_root}/tmp/pids/puma_web.pid"
state_path "#{app_root}/tmp/pids/puma_web.state"
bind 'unix:///var/www/dot_api/tmp/sockets/puma_web.sock'
# daemonize true
port 3000
workers 4
threads 8, 16
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end
