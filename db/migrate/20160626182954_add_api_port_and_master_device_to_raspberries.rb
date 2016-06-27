class AddApiPortAndMasterDeviceToRaspberries < ActiveRecord::Migration[5.0]
  def change
    add_column :raspberries, :api_port, :integer
    add_column :raspberries, :master_device, :boolean, default: false
  end
end
