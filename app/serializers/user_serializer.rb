class UserSerializer < ActiveModel::Serializer
  attributes :admin, :approved, :created_at, :email, :firstname, :lastname
  attribute :avatar_file_name, key: :avatar
  # attribute :encrypted_password, key: :password
  attribute :authentication_token, key: :token
end
