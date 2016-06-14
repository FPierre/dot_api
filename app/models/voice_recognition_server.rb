require 'resolv'

class VoiceRecognitionServer < ApplicationRecord
  validates :ip_address, format: { with: Resolv::IPv4::Regex }
  validates :mac_address, format: { with: /\A([0-9A-F]{2}[-:]){5}([0-9A-F]{2})\z/ }
end
