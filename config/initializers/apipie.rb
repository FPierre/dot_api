Apipie.configure do |config|
  config.api_base_url            = "/api/v1"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.app_name                = "DotApi"
  config.doc_base_url            = "/apipie"
  config.validate                = false
end
