class MessagesController < ApplicationController


    def create
      if current_user.id == message_params[:recipient_id]
        redirect_to request.referrer, alert: "自分自身にメッセージは送れません"
      end

      conversation = Conversation.where("(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)",
                                        current_user.id, message_params[:recipient_id],
                                        params[:recipient_id], current_user.id).first

      if !conversation.present?
        conversation = Conversation.create(sender_id: current_user.id, recipient_id: message_params[:recipient_id])
      end

      @message = Message.new(user_id: current_user.id,
                            conversation_id: conversation.id,
                            content: message_params[:content]
      )

      if @message.save
        flash[:notice] = "メッセージを送信しました!"
      else
        flash[:alert] = "メッセージが送れませんでした"
      end
      redirect_back(fallback_location: request.referer)
    end

    private

      def message_params
        params.require(:message).permit(:content, :recipient_id)
      end
end
