class ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :list_id, :created_at, :completed
end
