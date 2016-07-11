class ReminderDisplayWorker
  include Sidekiq::Worker

  def perform id
    ap 'ReminderDisplayWorker#perform'
    reminder = Reminder.find id
  rescue ActiveRecord::RecordNotFound => e
    ap e.message
  else
    if Setting.first.reminders_enabled
      ActionCable.server.broadcast 'notification_channel', notification: reminder.to_serialize
    end
  end
end
