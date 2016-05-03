class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|
      t.boolean :sarah_enabled, default: true
      t.boolean :twitter_enabled, default: true
      t.boolean :reminders_enabled, default: true
      t.boolean :weather_enabled, default: true
      t.boolean :weather_current_day_only, default: true

      t.timestamps
    end
  end
end
