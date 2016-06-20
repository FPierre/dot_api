require 'test_helper'

class ScreenRoutesTest < ActionController::TestCase
  test 'should route to team screen' do
    assert_routing(api_route('/screens/team'),
                   { controller: api_controller('screens'), action: 'team' })
  end

  test 'should route to guest screen' do
    assert_routing(api_route('/screens/guest'),
                   { controller: api_controller('screens'), action: 'guest' })
  end

  test 'should route to news screen' do
    assert_routing(api_route('/screens/news'),
                   { controller: api_controller('screens'), action: 'news' })
  end

  test 'should route to resize screen size' do
    assert_routing(api_route('/screens/resize/zone/:zone/size/:size'),
                   { controller: api_controller('screens'), action: 'resize', zone: '1', size: 'half' })
  end

  test 'should route to find path for map on screen' do
    assert_routing({ api_route('/screens/path/from/:from/to/:to'),
                   { controller: api_controller('reminders'), action: 'destroy', from: 'Paris', to: 'Lyon' })
  end
end
