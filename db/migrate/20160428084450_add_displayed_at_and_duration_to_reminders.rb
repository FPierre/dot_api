class AddDisplayedAtAndDurationToReminders < ActiveRecord::Migration[5.0]
  def change
    add_column :reminders, :display_at, :datetime
    add_column :reminders, :duration, :integer, limit: 2, default: 1, null: false
  end
end
