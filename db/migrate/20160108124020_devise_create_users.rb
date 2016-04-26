class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      # Validatable
      t.boolean :approved, null: false, default: false

      t.string :authentication_token, default: ''

      t.attachment :avatar
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.boolean :admin, default: false

      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :authentication_token, unique: true
    add_index :users, :approved
  end
end
