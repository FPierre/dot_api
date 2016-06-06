class CreateRaspberries < ActiveRecord::Migration[5.0]
  def change
    create_table :raspberries do |t|
      t.string :name, limit: 255, null: false
      t.string :ip_address, null: false
      t.string :mac_address, null: false

      t.timestamps
    end
  end
end
