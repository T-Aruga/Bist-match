class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :content, presence: true

  after_create_commit :create_notification

  def message_time
    created_at.strftime('%v')
  end

  private

  # メッセージ送信時に相手に通知する
  def create_notification
    if conversation.sender_id == user_id
      sender = User.find(conversation.sender_id)
      notification = Notification.create(content: "#{sender.fullname}さんから新しいメッセージが届きました", user_id: conversation.recipient_id)
      notification.user.increment!(:unread)
    else
      sender = User.find(conversation.recipient_id)
      notification = Notification.create(content: "#{sender.fullname}さんから新しいメッセージが届きました", user_id: conversation.sender_id)
      notification.user.increment!(:unread)
    end
  end
end
