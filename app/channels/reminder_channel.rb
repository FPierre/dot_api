# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class ReminderChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'reminder_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak reminder
    ActionCable.server.broadcast 'reminder_channel', path: data['reminder']
  end
end
