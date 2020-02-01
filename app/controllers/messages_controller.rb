class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    recipient_id = message_params[:recipient_id].to_i

    # 自分へのメッセージは不可
    if current_user.id == recipient_id
      redirect_to request.referer, alert: '自分自身にメッセージは送れません'
    end

    # 現在選択中ののトークルームの取得
    conversation = Conversation.between(current_user.id, recipient_id).first

    # トークルームが存在しなければ、新たに作成する
    if conversation.blank?
      conversation = Conversation.create(sender_id: current_user.id, recipient_id: recipient_id)
    end

    @message = Message.new(user_id: current_user.id,
                           conversation_id: conversation.id,
                           content: message_params[:content])

    if @message.save
      conversation.update!(updated_at: @message.created_at)
      receipient = conversation.sender.id == current_user.id ? conversation.recipient : conversation.sender

      MessagesChannel.broadcast_to conversation,
                                   sender_id: current_user.id,
                                   sender: render_message(@message, current_user),
                                   receipient: render_message(@message, receipient)

      if URI(request.referer).path == conversation_detail_path(id: receipient.id)
        return render json: { success: true }
      end

      # トークルーム以外（マイページ）からのメッセージはflashが発生する
      flash[:notice] = 'メッセージを送信しました!'
    else
      flash[:alert] = 'メッセージが送れませんでした'
    end
    redirect_to request.referer
  end

  private

  def render_message(message, user)
    render_to_string partial: 'conversations/message', locals: { m: message, user: user }
  end

  def message_params
    params.require(:message).permit(:content, :recipient_id)
  end
end
