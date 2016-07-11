class VoiceRecognitionServerSerializer < ActiveModel::Serializer
  attributes :id, :api_port, :domain_name, :ip_address, :mac_address
end
