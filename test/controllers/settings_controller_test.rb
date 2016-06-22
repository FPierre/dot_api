require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @setting = settings(:one)
  end

  test "should show setting" do
    get api_v1_setting_url(@setting)
    assert_response :success
  end

  test "should update setting" do
    patch api_v1_setting_url(@setting), params: { setting: {  } }
    assert_response 200
  end
end
