# DotApi

## Getting started

Run Web server:

```bash
$ bundle exec puma -e production -C config/puma_web.rb -d
```

Run Websocket server:

Redis must be started.

```bash
$ ./bin/cable
```

Sidekiq must be started (and must have the right environment):

```bash
$ bundle exec sidekiq -d -e production
```

ruby twitter_daemon.rb start

Config ActionCable :  Rails.configuration.action_cable


whenever --update-crontab
