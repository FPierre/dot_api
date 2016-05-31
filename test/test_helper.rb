ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def api_url_prefix
    'api/v1'
  end

  def api_route resource_path
    "#{api_url_prefix}#{resource_path}"
  end

  def api_controller resource_controller
    "#{api_url_prefix}/#{resource_controller}"
  end
end
