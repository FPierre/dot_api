class RaspberrySerializer < ActiveModel::Serializer
  attributes :id, :created_at, :ip_address, :mac_address, :name
end
