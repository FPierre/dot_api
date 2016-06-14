class CreateVoiceRecognitionServers < ActiveRecord::Migration[5.0]
  def change
    create_table :voice_recognition_servers do |t|
      t.string :ip_address
      t.string :mac_address

      t.timestamps
    end
  end
end
