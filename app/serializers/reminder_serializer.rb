class ReminderSerializer < ActiveModel::Serializer
  attributes :content, :created_at, :display_at, :duration, :id, :priority, :title

  belongs_to :user
end
