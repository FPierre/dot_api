class Reminder < ApplicationRecord
  belongs_to :user

  validates :content, length: { in: 1..75 }, presence: true
  validates :duration, length: { in: 1..2 }
  validates :priority, length: { is: 1 }
  validates :user, presence: true

  after_create -> { ActionCable.server.broadcast 'reminder_channel', { reminder: self }}
end
