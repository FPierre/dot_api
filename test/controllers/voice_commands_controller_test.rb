require 'test_helper'

class VoiceCommandsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index with admin user' do
    user_admin = users :user_admin
    get api_v1_voice_commands_url, params: { email: user_admin.email, token: user_admin.authentication_token }
    assert_response :success
  end

  test 'should get index with approved user' do
    user_approved = users :user_approved
    get api_v1_voice_commands_url, params: { email: user_approved.email, token: user_approved.authentication_token }
    assert_response :success
  end

  test 'should not get index with unapproved user' do
    user_unapproved = users :user_unapproved
    get api_v1_voice_commands_url, params: { email: user_unapproved.email, token: user_unapproved.authentication_token }
    assert_response 403
  end

  test 'should not get index without user' do
    get api_v1_voice_commands_url
    assert_response 401
  end
end
