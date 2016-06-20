class RemoveWeatherEnabledAndWeatherCurrentDayOnlyFromSettings < ActiveRecord::Migration[5.0]
  def change
    remove_column :settings, :weather_enabled, :bool
    remove_column :settings, :weather_current_day_only, :bool
  end
end
