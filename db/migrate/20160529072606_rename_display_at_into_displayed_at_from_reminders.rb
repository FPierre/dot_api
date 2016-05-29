class RenameDisplayAtIntoDisplayedAtFromReminders < ActiveRecord::Migration[5.0]
  def change
    rename_column :reminders, :display_at, :displayed_at
  end
end
