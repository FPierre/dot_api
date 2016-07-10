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

  # after_save -> { ReminderDisplayWorker.perform_at(displayed_at, id) if displayed_at >= DateTime.now }
  after_commit :sidekiq_enqueue, on: :create

  def sidekiq_enqueue
    ReminderDisplayWorker.perform_at(displayed_at, id) if displayed_at
  end

  def to_serialize
    ActiveModelSerializers::SerializableResource.new(self, {}).as_json
  end
end
