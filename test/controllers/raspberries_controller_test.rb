require 'test_helper'

class RaspberriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @raspberry = raspberries :one
  end

  test "should get index" do
    get api_v1_raspberries_url
    assert_response :success
  end

  test "should create raspberry" do
    assert_difference('Raspberry.count') do
      post api_v1_raspberries_url, params: {
        name: 'Raspberry Slave',
        ip_address: '32.147.150.167',
        mac_address: '34-D2-EB-F8-44-A2'
      }
    end

    assert_response 201
  end

  test "should show raspberry" do
    get api_v1_raspberry_url(@raspberry)
    assert_response :success
  end

  test "should update raspberry" do
    patch api_v1_raspberry_url(@raspberry), params: { raspberry: {}}
    assert_response 200
  end

  # test "should destroy raspberry" do
  #   assert_difference('Raspberry.count', -1) do
  #     request_with_token :admin do
  #       delete api_v1_raspberry_url(@raspberry)
  #     end
  #   end

  #   assert_response 204
  # end
end
