class SettingSerializer < ActiveModel::Serializer
  attributes :reminders_enabled, :sarah_enabled, :twitter_enabled, :weather_current_day_only, :weather_enabled
end
