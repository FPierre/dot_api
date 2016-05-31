require 'test_helper'

class VoiceCommandsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get api_v1_voice_commands_url
    assert_response :success
  end
end
