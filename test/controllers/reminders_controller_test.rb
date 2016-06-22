require 'test_helper'

class RemindersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reminder = reminders(:one)
  end

  test 'should get index' do
    get api_v1_reminders_url
    assert_response :success
  end

  test 'should create reminder' do
    assert_difference('Reminder.count') do
      post api_v1_reminders_url, params: { reminder: {  } }
    end

    assert_response 201
  end

  test 'should show reminder' do
    get api_v1_reminder_url(@reminder)
    assert_response :success
  end

  test 'should destroy reminder' do
    assert_difference('Reminder.count', -1) do
      delete api_v1_reminder_url(@reminder)
    end

    assert_response 204
  end
end
