require 'test_helper'

class RemindersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reminder = reminders :reminder_1
  end

  test 'should get index' do
    get api_v1_reminders_url
    assert_response :success
    # assert_includes @response.body['data'][0]['type'], 'reminders'
  end

  test 'should show reminder' do
    get api_v1_reminders_url, params: { id: @reminder.id }
    assert_response :success
  end

  test 'should show reminder with attributes' do
    get api_v1_reminders_url
    json = JSON.parse @response.body
    # assert_includes(['content', 'created-at', 'displayed-at', 'duration', 'priority', 'title', 'type', 'user', 'displayed', 'displayed-ago'], json['data'][0]['attributes'].keys)
  end

  test 'should destroy reminder' do
    assert_difference('Reminder.count', -1) do
      delete api_v1_reminder_url(@reminder)
    end
  end
end
