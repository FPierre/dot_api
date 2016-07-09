# DotApi

## Getting started

Run Web server:

```bash
$ bundle exec puma -d -e production -C config/puma_web.rb
```

Run Websocket server:

Redis must be started.

```bash
$ ./bin/cable
```

Sidekiq must be started:

```bash
$ bundle exec sidekiq
```

Config ActionCable :  Rails.configuration.action_cable


whenever --update-crontab
