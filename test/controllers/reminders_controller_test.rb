require 'test_helper'

class RemindersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reminder = reminders :one
    @user = users :user_approved
  end

  test 'should get index' do
    request_with_token :admin do |params|
      get params.api_v1_reminders_url
    end

    assert_response :success
  end

  test 'should show reminder' do
    request_with_token :admin do |params|
      get params.api_v1_reminder_url(@reminder)
    end

    assert_response :success
  end

  test 'should destroy reminder' do
    assert_difference('Reminder.count', -1) do
      request_with_token :admin do |params|
        delete params.api_v1_reminder_url(@reminder)
      end
    end

    assert_response 200
  end
end
