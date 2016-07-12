require 'test_helper'

class VoiceRecognitionServersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @voice_recognition_server = voice_recognition_servers :one
  end

  test 'should show voice_recognition_server' do
    get voice_recognition_servers(@voice_recognition_server)
    assert_response :success
  end

  test 'should update voice_recognition_server' do
    patch voice_recognition_servers(@voice_recognition_server), params: {}
    assert_response 200
  end
end
