class CreateReminders < ActiveRecord::Migration[5.0]
  def change
    create_table :reminders do |t|
      t.string :title, limit: 255
      t.string :content, limit: 75, null: false
      t.integer :priority, default: 3, null: false

      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
