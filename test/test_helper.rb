ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

module RequestTokenHelper
  def request_with_token user_status
    user = users("user_#{user_status}")

    with_options params: { email: user.email, token: user.authentication_token } do |params|
      yield params
    end
  end
end

class ActiveSupport::TestCase
  include RequestTokenHelper

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  attr_accessor :user_admin

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
