class Message < ApplicationRecord

  belongs_to :user
  belongs_to :conversation

  after_create_commit :create_notification

  def message_time
    self.created_at.strftime("%v")
  end

  private
    # メッセージ送信時に相手に通知する
    def create_notification
      if self.conversation.sender_id == self.user_id
        sender = User.find(self.conversation.sender_id)
        notification = Notification.create(content: "#{sender.fullname}さんから新しいメッセージが届きました", user_id: self.conversation.recipient_id)
        notification.user.increment!(:unread)
      else
        sender = User.find(self.conversation.recipient_id)
        notification = Notification.create(content: "#{sender.fullname}さんから新しいメッセージが届きました", user_id: self.conversation.sender_id)
        notification.user.increment!(:unread)
      end
    end
end
