require 'resolv'

class Raspberry < ApplicationRecord
  validates :ip_address, presence: true, uniqueness: true, format: { with: Resolv::IPv4::Regex }
  validates :mac_address, presence: true, uniqueness: true, format: { with: /\A([0-9A-F]{2}[-:]){5}([0-9A-F]{2})\z/ }
end
