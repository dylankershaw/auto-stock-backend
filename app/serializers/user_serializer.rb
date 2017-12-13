class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :string, :password_digest
end
