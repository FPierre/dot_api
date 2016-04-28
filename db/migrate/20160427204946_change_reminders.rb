class ChangeReminders < ActiveRecord::Migration[5.0]
  def change
    add_reference :reminders, :user, index: true, foreign_key: true
    change_column :reminders, :content, :string, limit: 75
    add_column :reminders, :priority, :integer, default: 3
  end
end
