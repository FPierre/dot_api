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

  test 'should route to resize screen size' do
    assert_routing(api_route('/screens/resize/zone/1/size/full'),
                   { controller: api_controller('screens'), action: 'resize' })
  end

  test 'should route to find path for map on screen' do
    assert_routing(api_route('/screens/path/from/Paris/to/Lyon'),
                   { controller: api_controller('screens'), action: 'path' })
  end
end
