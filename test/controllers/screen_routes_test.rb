require 'test_helper'

class ScreenRoutesTest < ActionController::TestCase
  test 'should route to find path for map on screen' do
    assert_generates(api_route('/screens/path/from/Paris/to/Lyon'),
                     { controller: api_controller('screens'), action: 'path', from: 'Paris', to: 'Lyon' })
  end
end
