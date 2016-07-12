class Raspberry < ApplicationRecord
  with_options presence: true, uniqueness: true do
    validates :name
    # MAC address validation regex
    validates :mac_address, format: { with: /\A([0-9A-F]{2}[-:]){5}([0-9A-F]{2})\z/ }
  end
end
