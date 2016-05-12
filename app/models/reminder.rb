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

  after_create -> {
    ActionCable.server.broadcast 'notification_channel', notification: self.to_serialize
  }

  private
    def to_serialize
      ActiveModelSerializers::SerializableResource.new(self, {}).as_json
    end
end
