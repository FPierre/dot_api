require 'test_helper'

class Api::V1::RaspberriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_raspberry = api_v1_raspberries(:one)
  end

  test "should get index" do
    get api_v1_raspberries_url
    assert_response :success
  end

  test "should create api_v1_raspberry" do
    assert_difference('Api::V1::Raspberry.count') do
      post api_v1_raspberries_url, params: { api_v1_raspberry: {  } }
    end

    assert_response 201
  end

  test "should show api_v1_raspberry" do
    get api_v1_raspberry_url(@api_v1_raspberry)
    assert_response :success
  end

  test "should update api_v1_raspberry" do
    patch api_v1_raspberry_url(@api_v1_raspberry), params: { api_v1_raspberry: {  } }
    assert_response 200
  end

  test "should destroy api_v1_raspberry" do
    assert_difference('Api::V1::Raspberry.count', -1) do
      delete api_v1_raspberry_url(@api_v1_raspberry)
    end

    assert_response 204
  end
end
