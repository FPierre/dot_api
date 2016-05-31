require 'test_helper'

class SettingRoutesTest < ActionController::TestCase
  test 'should route to setting' do
    assert_routing(api_route('/settings/1'),
                   { controller: api_controller('settings'), action: 'show', id: '1' })
  end

  test 'should route to update setting' do
    assert_routing({ method: 'put', path: api_route('/settings/1') },
                   { controller: api_controller('settings'), action: 'update', id: '1' })

    assert_routing({ method: 'patch', path: api_route('/settings/1') },
                   { controller: api_controller('settings'), action: 'update', id: '1' })
  end
end
