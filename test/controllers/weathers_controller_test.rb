require 'test_helper'

class WeathersControllerTest < ActionDispatch::IntegrationTest
  test 'should show weather' do
    get api_v1_weather_url
    assert_response :success
  end
end
