require 'test_helper'

class Api::V1::RaspberriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @raspberry = raspberries :raspberry_one
  end

  test 'should get index' do
    get api_v1_raspberries_url
    assert_response :success
  end

  test 'should create raspberry' do
    assert_difference('Raspberry.count') do
      post api_v1_raspberries_url, params: { raspberry: {  } }
    end

    assert_response 201
  end

  test 'should show raspberry' do
    get api_v1_raspberry_url(@raspberry)
    assert_response :success
  end

  test 'should update raspberry' do
    patch api_v1_raspberry_url(@raspberry), params: { raspberry: {  } }
    assert_response 200
  end

  test 'should destroy raspberry' do
    assert_difference('Raspberry.count', -1) do
      delete api_v1_raspberry_url(@raspberry)
    end

    assert_response 204
  end
end
