# require 'resolv'

class Raspberry < ApplicationRecord
  with_options presence: true, uniqueness: true do
    validates :name
    # validates :ip_address, format: { with: Resolv::IPv4::Regex }
    validates :mac_address, format: { with: /\A([0-9A-F]{2}[-:]){5}([0-9A-F]{2})\z/ }
  end
end
