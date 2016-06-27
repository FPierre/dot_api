class AddApiPortToVoiceRecognitionServer < ActiveRecord::Migration[5.0]
  def change
    add_column :voice_recognition_servers, :api_port, :integer
  end
end
