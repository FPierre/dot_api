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

  after_save -> { ReminderDisplayWorker.perform_at(self.displayed_at, self.id) if self.displayed_at }

  def to_serialize
    ActiveModelSerializers::SerializableResource.new(self, {}).as_json
  end
end
