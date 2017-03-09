class ListSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :user_id, :private
end
