class UserSerializer < ActiveModel::Serializer
  attributes :admin, :approved, :authentication_token, :created_at, :email, :firstname, :id, :lastname, :updated_at
end
