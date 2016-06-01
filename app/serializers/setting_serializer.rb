class SettingSerializer < ActiveModel::Serializer
  attributes :reminders_enabled, :room_occupied, :sarah_enabled, :screen_guest_enabled, :twitter_enabled,
             :weather_current_day_only, :weather_enabled
end
