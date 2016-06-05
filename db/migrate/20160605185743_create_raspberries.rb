class CreateApiV1Raspberries < ActiveRecord::Migration[5.0]
  def change
    create_table :raspberries do |t|

      t.timestamps
    end
  end
end
