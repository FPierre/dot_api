class AddRoomOccupiedAndScreenGuestEnabled < ActiveRecord::Migration[5.0]
  def change
    add_column :settings, :room_occupied, :boolean, default: false
    add_column :settings, :screen_guest_enabled, :boolean, default: false
  end
end
