class RaspberrySerializer < ActiveModel::Serializer
  attributes :id, :api_port, :created_at, :ip_address, :mac_address, :master_device, :name
end
