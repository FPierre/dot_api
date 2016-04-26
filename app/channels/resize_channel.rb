# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class ResizeChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'resize_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak resize
    ActionCable.server.broadcast 'resize_channel', resize: data['resize']
  end
end
