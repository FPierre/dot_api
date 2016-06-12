# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class ScreenModeChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'screen_mode_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak data
    ActionCable.server.broadcast 'screen_mode_channel', mode: data['mode']
  end
end
