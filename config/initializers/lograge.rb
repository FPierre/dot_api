DotApi::Application.configure do
  config.lograge.enabled = true

  config.lograge.custom_options = lambda do |event|
    unwanted_keys = %w[format action controller]
    params = event.payload[:params].reject{ |key, _| unwanted_keys.include? key }
    Hash[time: event.time, params: params]
  end
end
