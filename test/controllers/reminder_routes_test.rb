require 'test_helper'

class ReminderRoutesTest < ActionController::TestCase
  test 'should route to reminders' do
    assert_routing(api_route('/reminders'),
                   { controller: api_controller('reminders'), action: 'index' })
  end

  test 'should route to reminder' do
    assert_routing(api_route('/reminders/1'),
                   { controller: api_controller('reminders'), action: 'show', id: '1' })
  end

  test 'should route to create reminder' do
    assert_routing({ method: 'post', path: api_route('/reminders') },
                   { controller: api_controller('reminders'), action: 'create' })
  end

  test 'should route to destroy reminder' do
    assert_routing({ method: 'delete', path: api_route('/reminders/1') },
                   { controller: api_controller('reminders'), action: 'destroy', id: '1' })
  end
end
