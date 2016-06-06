require 'test_helper'

class RaspberryRoutesTest < ActionController::TestCase
  test 'should route to raspberries' do
    assert_routing(api_route('/raspberries'),
                   { controller: api_controller('raspberries'), action: 'index' })
  end

  test 'should route to raspberry' do
    assert_routing(api_route('/raspberries/1'),
                   { controller: api_controller('raspberries'), action: 'show', id: '1' })
  end

  test 'should route to create raspberry' do
    assert_routing({ method: 'post', path: api_route('/raspberries') },
                   { controller: api_controller('raspberries'), action: 'create' })
  end

  test 'should route to update raspberry' do
    assert_routing({ method: 'put', path: api_route('/raspberries/1') },
                   { controller: api_controller('raspberries'), action: 'update', id: '1' })

    assert_routing({ method: 'patch', path: api_route('/raspberries/1') },
                   { controller: api_controller('raspberries'), action: 'update', id: '1' })
  end

  test 'should route to destroy raspberry' do
    assert_routing({ method: 'delete', path: api_route('/raspberries/1') },
                   { controller: api_controller('raspberries'), action: 'destroy', id: '1' })
  end
end
