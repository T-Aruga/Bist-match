class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  def message_time
    self.created_at.strftime("%v")
  end
end
