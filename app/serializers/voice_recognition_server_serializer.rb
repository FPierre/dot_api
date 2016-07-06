class VoiceRecognitionServerSerializer < ActiveModel::Serializer
  attributes :id, :api_port, :ip_address, :mac_address
end
