require 'test_helper'

class VoiceRecognitionServerRoutesTest < ActionController::TestCase
  test 'should route to voice recognition server' do
    assert_routing(api_route('/voice_recognition_servers/1'),
                   { controller: api_controller('voice_recognition_servers'), action: 'show', id: '1' })
  end

  test 'should route to update voice recognition server' do
    assert_routing({ method: 'put', path: api_route('/voice_recognition_servers/1') },
                   { controller: api_controller('voice_recognition_servers'), action: 'update', id: '1' })

    assert_routing({ method: 'patch', path: api_route('/voice_recognition_servers/1') },
                   { controller: api_controller('voice_recognition_servers'), action: 'update', id: '1' })
  end
end
