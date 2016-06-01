class ReminderDisplayWorker
  include Sidekiq::Worker

  def perform id
    ap 'ReminderDisplayWorker#perform'
    reminder = Reminder.find id
  rescue ActiveRecord::RecordNotFound => e
    ap e.message
  else
    ActionCable.server.broadcast 'notification_channel', notification: reminder.to_serialize
  end
end
