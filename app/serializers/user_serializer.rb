class UserSerializer < ActiveModel::Serializer
  # attributes :admin, :approved, :authentication_token, :created_at, :email, :firstname, :id, :lastname, :updated_at

  attribute :admin,                key: :admin
  attribute :approved,             key: :approved
  attribute :authentication_token, key: :token
  attribute :created_at,           key: :createdAt
  attribute :email,                key: :email
  attribute :encrypted_password,   key: :password
  attribute :firstname,            key: :firstname
  attribute :id,                   key: :userId
  attribute :lastname,             key: :lastname
end
