require 'test_helper'

class UserRoutesTest < ActionController::TestCase
  test 'should route to users' do
    assert_routing(api_route('/users'),
                   { controller: api_controller('users'), action: 'index' })
  end

  test 'should route to user' do
    assert_routing(api_route('/users/1'),
                   { controller: api_controller('users'), action: 'show', id: '1' })
  end

  test 'should route to create user' do
    assert_routing({ method: 'post', path: api_route('/users') },
                   { controller: api_controller('users'), action: 'create' })
  end

  test 'should route to update user' do
    assert_routing({ method: 'put', path: api_route('/users/1') },
                   { controller: api_controller('users'), action: 'update', id: '1' })

    assert_routing({ method: 'patch', path: api_route('/users/1') },
                   { controller: api_controller('users'), action: 'update', id: '1' })
  end

  test 'should route to destroy user' do
    assert_routing({ method: 'delete', path: api_route('/users/1') },
                   { controller: api_controller('users'), action: 'destroy', id: '1' })
  end
end
