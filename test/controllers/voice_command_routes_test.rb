require 'test_helper'

class VoiceCommandRoutesTest < ActionController::TestCase
  test 'should route to voice command' do
    assert_routing(api_route('/voice_commands'),
                   { controller: api_controller('voice_commands'), action: 'index' })
  end
end
