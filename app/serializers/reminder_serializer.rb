class ReminderSerializer < ActiveModel::Serializer
  attributes :content, :created_at, :display_at, :duration, :id, :priority, :title
  attributes :type, :user
  # belongs_to :user

  def user
    object.user.to_s
  end

  def type
    if object.display_at.present?
      :alert
    else
      :memo
    end
  end
end
