require 'test_helper'

class RemindersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reminder = reminders :reminder_1
  end

  test 'should get index' do
    request_with_token(:admin) do |params|
      params.get api_v1_reminders_url
    end

    assert_response :success
    # assert_includes @response.body['data'][0]['type'], 'reminders'
  end

  test 'should show reminder' do
    request_with_token(:admin) do |params|
      params.get api_v1_reminders_url, params: { id: @reminder.id }
    end

    assert_response :success
  end

  test 'should show reminder with attributes' do
    request_with_token(:admin) do |params|
      params.get api_v1_reminders_url
    end

    json = JSON.parse @response.body
    # assert_includes(['content', 'created-at', 'displayed-at', 'duration', 'priority', 'title', 'type', 'user', 'displayed', 'displayed-ago'], json['data'][0]['attributes'].keys)
  end

  test 'should destroy reminder' do
    request_with_token(:admin) do |params|
      assert_difference('Reminder.count', -1) do
        params.delete api_v1_reminder_url(@reminder)
      end
    end
  end
end
