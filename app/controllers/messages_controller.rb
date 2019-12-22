class MessagesController < ApplicationController
    before_action :authenticate_user!

    def create
      if current_user.id == message_params[:recipient_id]
        redirect_to request.referrer, alert: "自分自身にメッセージは送れません"
      end

      conversation = Conversation.where("(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)",
                                        current_user.id, message_params[:recipient_id],
                                        message_params[:recipient_id], current_user.id).first

      if !conversation.present?
        recipient_id = message_params[:recipient_id].to_i
        conversation = Conversation.create(sender_id: current_user.id, recipient_id: recipient_id)
      end

      @message = Message.new(user_id: current_user.id,
                            conversation_id: conversation.id,
                            content: message_params[:content]
      )

      if @message.save
        conversation.update!(updated_at: @message.created_at)
        receipient = conversation.sender.id == current_user.id ? conversation.recipient : conversation.sender

        MessagesChannel.broadcast_to conversation,
                                  sender_id: current_user.id,
                                  sender: render_message(@message, current_user),
                                  receipient: render_message(@message, receipient)

        if URI(request.referrer).path == conversation_detail_path(id: receipient.id)
          return render json: {success: true}
        end


        flash[:notice] = "メッセージを送信しました!"
      else
        flash[:alert] = "メッセージが送れませんでした"
      end
      redirect_to request.referrer
    end

    private

      def render_message(message, user)
        self.render_to_string partial: 'conversations/message', locals: {m: message, user: user}
      end

      def message_params
        params.require(:message).permit(:content, :recipient_id)
      end
end
