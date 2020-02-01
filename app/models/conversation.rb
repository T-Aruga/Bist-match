class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy

  # 最新のメッセージを取得
  def last_message
    message = Message.where(conversation_id: id).last
    message.presence || Message.new(updated_at: Time.zone.now)
  end
  # 現在選択中のトークルームの取得
  scope :between, lambda { |user_A, user_B|
    where('(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)',
          user_A, user_B,
          user_B, user_A)
  }
end
