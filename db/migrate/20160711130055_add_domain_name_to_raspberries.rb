class AddDomainNameToRaspberries < ActiveRecord::Migration[5.0]
  def change
    add_column :raspberries, :domain_name, :string
  end
end
