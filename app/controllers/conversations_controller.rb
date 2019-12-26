class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_conversations


  def show
      @user = User.find(params[:id])

      @conversation = Conversation.where("(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)",
                                              current_user.id, params[:id],
                                              params[:id], current_user.id
                                          ).first
      if !@conversation.present?
          redirect_to conversations_path, alert: "無効なアクセスです"
      else
          @messages = Message.includes(:user).where(conversation_id: @conversation.id)
      end
  end

  private

  def get_conversations
      @conversations = Conversation
                          .where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
                          .order(updated_at: :desc)
  end
end
