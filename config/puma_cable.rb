app_root = '/var/www/dot_api'
pidfile "#{app_root}/tmp/pids/puma_cable.pid"
state_path "#{app_root}/tmp/pids/puma_cable.state"
workers 1
threads 16, 64
port 7001
preload_app!
# daemonize true

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end
