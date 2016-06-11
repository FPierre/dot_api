class ReminderSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  attributes :content, :created_at, :displayed_at, :duration, :id, :priority, :title, :type, :user, :displayed, :displayed_ago

  def user
    object.user.to_s
  end

  def type
    object.displayed_at.present? ? :alert : :memo
  end

  def displayed
    (object.displayed_at && object.displayed_at > DateTime.now) ? false : true
  end

  def displayed_ago
    time_ago_in_words(object.displayed_at) if object.displayed_at.present?
  end
end

