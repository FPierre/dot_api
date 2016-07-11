class Reminder < ApplicationRecord
  belongs_to :user

  validates :content, length: { in: 1..75 }, presence: true
  validates :duration, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 60
  }
  validates :priority, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 3
  }
  validates :user, presence: true

  after_save :broadcast_to_channel, unless: Proc.new { |reminder| reminder.displayed_at? }
  after_commit :sidekiq_enqueue, on: :create, if: Proc.new { |reminder| reminder.displayed_at? }

  # Send to Websocket client
  def broadcast_to_channel
    if Setting.first.reminders_enabled
      ActionCable.server.broadcast 'notification_channel', notification: self.to_serialize
    end
  end

  # If displayed_at is given, append to Sidekiq queue
  def sidekiq_enqueue
    ReminderDisplayWorker.perform_at(displayed_at, id)
  end

  def to_serialize
    ActiveModelSerializers::SerializableResource.new(self, {}).as_json
  end
end
