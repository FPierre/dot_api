require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @setting = settings :setting_1
  end

  test 'should update setting' do
    patch api_v1_setting_url, params: { id: @setting.id, sarah_enabled: false }
    # Reload association to fetch updated data and assert that title is updated.
    @setting.reload
    assert_equal false, @setting.sarah_enabled
  end
end
