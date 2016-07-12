require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @setting = settings :one
  end

  test "should show setting" do
    get api_v1_setting_url(@setting)
    assert_response :success
  end

  test "should update setting" do
    request_with_token :admin do |params|
      patch params.api_v1_setting_url(@setting), params: {}
    end

    assert_response 200
  end
end
