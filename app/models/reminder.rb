class Reminder < ApplicationRecord
  belongs_to :user

  validates :title, :content, presence: true

  after_create -> { ActionCable.server.broadcast 'reminder_channel', { reminder: self }}
end
