class ReminderSerializer < ActiveModel::Serializer
  attributes :content, :created_at, :display_at, :duration, :id, :priority, :title, :updated_at, :user_id
end

