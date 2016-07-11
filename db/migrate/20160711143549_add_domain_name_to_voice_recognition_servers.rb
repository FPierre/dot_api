class AddDomainNameToVoiceRecognitionServers < ActiveRecord::Migration[5.0]
  def change
    add_column :voice_recognition_servers, :domain_name, :string
  end
end
