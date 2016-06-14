require 'test_helper'

class VoiceRecognitionServersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @voice_recognition_server = voice_recognition_servers(:one)
  end

  test "should get index" do
    get voice_recognition_servers_url
    assert_response :success
  end

  test "should create voice_recognition_server" do
    assert_difference('VoiceRecognitionServer.count') do
      post voice_recognition_servers_url, params: { voice_recognition_server: { ip_address,: @voice_recognition_server.ip_address,, mac_address: @voice_recognition_server.mac_address } }
    end

    assert_response 201
  end

  test "should show voice_recognition_server" do
    get voice_recognition_server_url(@voice_recognition_server)
    assert_response :success
  end

  test "should update voice_recognition_server" do
    patch voice_recognition_server_url(@voice_recognition_server), params: { voice_recognition_server: { ip_address,: @voice_recognition_server.ip_address,, mac_address: @voice_recognition_server.mac_address } }
    assert_response 200
  end

  test "should destroy voice_recognition_server" do
    assert_difference('VoiceRecognitionServer.count', -1) do
      delete voice_recognition_server_url(@voice_recognition_server)
    end

    assert_response 204
  end
end
