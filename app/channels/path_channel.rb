# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class PathChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'path_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak path
    ActionCable.server.broadcast 'path_channel', path: data['path']
  end
end
