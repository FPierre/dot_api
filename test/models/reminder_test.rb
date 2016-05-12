require 'test_helper'

class ReminderTest < ActiveSupport::TestCase
  def setup
    @reminder = Reminder.new
  end

  test 'Reminder is initialized with default priority' do
    assert_includes 1..3, @reminder.priority
  end

  test 'Reminder is initialized with default duration' do
    assert_includes 1..240, @reminder.duration
  end

  test 'Reminder is created with limited content size' do
    assert_raises(ActiveRecord::RecordInvalid) { Reminder.create! content: 'a' * 76 }
  end

  test 'Reminder is created with limited duration size' do
    assert_raises(ActiveRecord::RecordInvalid) { Reminder.create! duration: '1' * 3 }
  end
end
