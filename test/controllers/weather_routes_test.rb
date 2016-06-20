require 'test_helper'

class RaspberryRoutesTest < ActionController::TestCase
  test 'should route to weather' do
    assert_routing(api_route('/weather'),
                   { controller: api_controller('weather'), action: 'show'})
  end
end
