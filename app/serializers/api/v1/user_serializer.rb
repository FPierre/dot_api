class UserSerializer < ActiveModel::Serializer
  attributes :admin, :approved, :authentication_token, :email, :firstname, :id, :lastname
end
